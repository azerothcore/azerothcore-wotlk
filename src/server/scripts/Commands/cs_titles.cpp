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
#include "DBCStores.h"
#include "Player.h"

using namespace Acore::ChatCommands;

class titles_commandscript : public CommandScript
{
public:
    titles_commandscript() : CommandScript("titles_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable titlesSetCommandTable =
        {
            { "mask", HandleTitlesSetMaskCommand, SEC_GAMEMASTER, Console::No },
        };
        static ChatCommandTable titlesCommandTable =
        {
            { "add",     HandleTitlesAddCommand,     SEC_GAMEMASTER, Console::No },
            { "current", HandleTitlesCurrentCommand, SEC_GAMEMASTER, Console::No },
            { "remove",  HandleTitlesRemoveCommand,  SEC_GAMEMASTER, Console::No },
            { "set",     titlesSetCommandTable },
        };
        static ChatCommandTable commandTable =
        {
            { "titles", titlesCommandTable },
        };
        return commandTable;
    }

    static bool HandleTitlesCurrentCommand(ChatHandler* handler, Variant<Hyperlink<title>, uint16> titleId)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendErrorMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
            return false;

        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(titleId);
        if (!titleInfo)
        {
            handler->SendErrorMessage(LANG_INVALID_TITLE_ID, uint32(titleId));
            return false;
        }

        std::string tNameLink = handler->GetNameLink(target);
        std::string titleNameStr = Acore::StringFormat(target->getGender() == GENDER_MALE ? titleInfo->nameMale[handler->GetSessionDbcLocale()] : titleInfo->nameFemale[handler->GetSessionDbcLocale()], target->GetName());

        target->SetTitle(titleInfo);
        target->SetUInt32Value(PLAYER_CHOSEN_TITLE, titleInfo->bit_index);

        handler->PSendSysMessage(LANG_TITLE_CURRENT_RES, uint32(titleId), titleNameStr, tNameLink);

        return true;
    }

    static bool HandleTitlesAddCommand(ChatHandler* handler, Variant<Hyperlink<title>, uint16> titleId)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendErrorMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
            return false;

        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(titleId);
        if (!titleInfo)
        {
            handler->SendErrorMessage(LANG_INVALID_TITLE_ID, uint32(titleId));
            return false;
        }

        std::string tNameLink = handler->GetNameLink(target);
        std::string titleNameStr = Acore::StringFormat(target->getGender() == GENDER_MALE ? titleInfo->nameMale[handler->GetSessionDbcLocale()] : titleInfo->nameFemale[handler->GetSessionDbcLocale()], target->GetName());

        target->SetTitle(titleInfo);
        handler->PSendSysMessage(LANG_TITLE_ADD_RES, uint32(titleId), titleNameStr, tNameLink);

        return true;
    }

    static bool HandleTitlesRemoveCommand(ChatHandler* handler, Variant<Hyperlink<title>, uint16> titleId)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendErrorMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
            return false;

        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(titleId);
        if (!titleInfo)
        {
            handler->SendErrorMessage(LANG_INVALID_TITLE_ID, uint32(titleId));
            return false;
        }

        target->SetTitle(titleInfo, true);

        std::string tNameLink = handler->GetNameLink(target);
        std::string titleNameStr = Acore::StringFormat(target->getGender() == GENDER_MALE ? titleInfo->nameMale[handler->GetSessionDbcLocale()] : titleInfo->nameFemale[handler->GetSessionDbcLocale()], target->GetName());

        handler->PSendSysMessage(LANG_TITLE_REMOVE_RES, uint32(titleId), titleNameStr, tNameLink);

        if (!target->HasTitle(target->GetInt32Value(PLAYER_CHOSEN_TITLE)))
        {
            target->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, tNameLink);
        }

        return true;
    }

    //Edit Player KnownTitles
    static bool HandleTitlesSetMaskCommand(ChatHandler* handler, uint64 mask)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendErrorMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
            return false;

        uint64 titles2 = mask;

        for (uint32 i = 1; i < sCharTitlesStore.GetNumRows(); ++i)
            if (CharTitlesEntry const* tEntry = sCharTitlesStore.LookupEntry(i))
                titles2 &= ~(uint64(1) << tEntry->bit_index);

        mask &= ~titles2;                                     // remove non-existing titles

        target->SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES, mask);
        handler->SendSysMessage(LANG_DONE);

        if (!target->HasTitle(target->GetInt32Value(PLAYER_CHOSEN_TITLE)))
        {
            target->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, handler->GetNameLink(target));
        }

        return true;
    }
};

void AddSC_titles_commandscript()
{
    new titles_commandscript();
}

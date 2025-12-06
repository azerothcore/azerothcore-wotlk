/*
* Copyright (C) 2010 - 2016 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef CHATHANDLERMETHODS_H
#define CHATHANDLERMETHODS_H

#include "Chat.h"

namespace LuaChatHandler
{
    /**
     * Sends text to the chat handler
     *
     * @proto (text)
     * @proto (entry)
     * @param string text : text to display in chat or console
     * @param uint32 entry : id of the string to display
     */
    int SendSysMessage(lua_State* L, ChatHandler* handler)
    {
        if (lua_isnumber(L, 2))
        {
            uint32 entry = Eluna::CHECKVAL<uint32>(L, 2);
            handler->SendSysMessage(entry);
        }
        else
        {
            std::string text = Eluna::CHECKVAL<std::string>(L, 2);
            handler->SendSysMessage(text);
        }
        return 0;
    }

    /**
     * Returns `true` if the [ChatHandler] comes from the console, `false` if it comes from a player
     *
     * @return bool isConsole
     */
    int IsConsole(lua_State* L, ChatHandler* handler)
    {
        Eluna::Push(L, handler->IsConsole());
        return 1;
    }

    /**
     * Returns the [Player] associated with the handler. Returns `nil` in the case of a console handler
     *
     * @return [Player] player
     */
    int GetPlayer(lua_State* L, ChatHandler* handler)
    {
        Eluna::Push(L, handler->GetPlayer());
        return 1;
    }

    /**
     * Sends a message to all connected players
     *
     * @param string text : text to send
     */
    int SendGlobalSysMessage(lua_State* L, ChatHandler* handler)
    {
        std::string text = Eluna::CHECKVAL<std::string>(L, 2);
        handler->SendGlobalSysMessage(text.c_str());
        return 0;
    }

    /**
     * Sends a message to all connected Game Masters
     *
     * @param string text : text to send
     */
    int SendGlobalGMSysMessage(lua_State* L, ChatHandler* handler)
    {
        std::string text = Eluna::CHECKVAL<std::string>(L, 2);
        handler->SendGlobalGMSysMessage(text.c_str());
        return 0;
    }

    /**
     * Checks if the current security level is lower than the specified [Player]'s account
     *
     * @param [Player] player
     * @param [bool] strong = false : Forces non-player accounts (security level greater than `0`) to go through the regular check if set to `true`.<br>Also, if set to `true`, the current security level will be considered as lower than the [Player]'s security level if the two levels are equal
     * @return [bool] lower
     */
    int HasLowerSecurity(lua_State* L, ChatHandler* handler)
    {
        Player* player = Eluna::CHECKOBJ<Player>(L, 2);
        bool strong = Eluna::CHECKVAL<bool>(L, 3);
        Eluna::Push(L, handler->HasLowerSecurity(player, ObjectGuid::Empty, strong));
        return 1;
    }

    /**
     * Checks if the current security level is lower than the specified `account`'s level
     *
     * @param [uint32] account : the target account ID to compare security levels with
     * @param [bool] strong = false : Forces non-player accounts (security level greater than `0`) to go through the regular check if set to `true`.<br>Also, if set to `true`, the current security level will be considered as lower than the `account`'s security level if the two levels are equal
     * @return [bool] lower
     */
    int HasLowerSecurityAccount(lua_State* L, ChatHandler* handler)
    {
        uint32 account = Eluna::CHECKVAL<uint32>(L, 2);
        bool strong = Eluna::CHECKVAL<bool>(L, 3);
        Eluna::Push(L, handler->HasLowerSecurityAccount(nullptr, account, strong));
        return 1;
    }

    /**
     * Returns the selected [Player]
     *
     * @return [Player] player
     */
    int GetSelectedPlayer(lua_State* L, ChatHandler* handler)
    {
        Eluna::Push(L, handler->getSelectedPlayer());
        return 1;
    }

    /**
     * Returns the selected [Creature]
     *
     * @return [Creature] creature
     */
    int GetSelectedCreature(lua_State* L, ChatHandler* handler)
    {
        Eluna::Push(L, handler->getSelectedCreature());
        return 1;
    }

    /**
     * Returns the selected [Unit]
     *
     * @return [Unit] unit
     */
    int GetSelectedUnit(lua_State* L, ChatHandler* handler)
    {
        Eluna::Push(L, handler->getSelectedUnit());
        return 1;
    }

    /**
     * Returns the selected [WorldObject]
     *
     * @return [WorldObject] object
     */
    int GetSelectedObject(lua_State* L, ChatHandler* handler)
    {
        Eluna::Push(L, handler->getSelectedObject());
        return 1;
    }

    /**
     * Returns the selected [Player] or the current [Player] if nothing is targeted or the target is not a player
     *
     * @return [Player] player
     */
    int GetSelectedPlayerOrSelf(lua_State* L, ChatHandler* handler)
    {
        Eluna::Push(L, handler->getSelectedPlayerOrSelf());
        return 1;
    }

    /**
     * Checks if the `securityLevel` is available
     *
     * @param [uint32] securityLevel
     * @return [bool] isAvailable
     */
    int IsAvailable(lua_State* L, ChatHandler* handler)
    {
        uint32 securityLevel = Eluna::CHECKVAL<uint32>(L, 2);
        Eluna::Push(L, handler->IsAvailable(securityLevel));
        return 1;
    }

    /**
     * Returns `true` if other previously called [ChatHandler] methods sent an error
     *
     * @return [bool] sentErrorMessage
     */
    int HasSentErrorMessage(lua_State* L, ChatHandler* handler)
    {
        Eluna::Push(L, handler->HasSentErrorMessage());
        return 1;
    }
}
#endif

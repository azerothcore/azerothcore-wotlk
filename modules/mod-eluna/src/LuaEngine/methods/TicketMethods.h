/*
* Copyright (C) 2010 - 2016 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef TICKETMETHODS_H
#define TICKETMETHODS_H

/***
 * An instance of a spell, created when the spell is cast by a [Unit].
 *
 * Inherits all methods from: none
 */
namespace LuaTicket
{
    /**
     * Returns true if the [Ticket] is closed or false.
     *
     * @return bool is_closed
     */
    int IsClosed(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->IsClosed());
        return 1;
    }

    /**
     * Returns true if the [Ticket] is completed or false.
     *
     * @return bool is_completed
     */
    int IsCompleted(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->IsCompleted());
        return 1;
    }

    /**
     * Return true if this GUID is the same as the [Player] who created the [Ticket] or false.
     *
     * @param guid playerGuid : desired playerGuid
     *
     * @return bool same_guid
     */
    int IsFromPlayer(lua_State* L, GmTicket* ticket)
    {
        ObjectGuid guid = Eluna::CHECKVAL<ObjectGuid>(L, 2);

        Eluna::Push(L, ticket->IsFromPlayer(guid));
        return 1;
    }

    /**
     * Return true if the [Ticket] is assigned or false.
     *
     * @return bool is_assigned
     */
    int IsAssigned(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->IsAssigned());
        return 1;
    }

    /**
     * Return true if the [Ticket] is assigned to the GUID or false.
     *
     * @param guid playerGuid : desired playerGuid
     *
     * @return bool is_assigned_to
     */
    int IsAssignedTo(lua_State* L, GmTicket* ticket)
    {
        ObjectGuid guid = Eluna::CHECKVAL<ObjectGuid>(L, 2);

        Eluna::Push(L, ticket->IsAssignedTo(guid));
        return 1;
    }

    /**
     * Return true if the [Ticket] is not assigned to the GUID or false.
     *
     * @param guid playerGuid : desired playerGuid
     *
     * @return bool is_assigned_not_to
     */
    int IsAssignedNotTo(lua_State* L, GmTicket* ticket)
    {
        ObjectGuid guid = Eluna::CHECKVAL<ObjectGuid>(L, 2);

        Eluna::Push(L, ticket->IsAssignedNotTo(guid));
        return 1;
    }

    /**
     * Return the [Ticket] id.
     *
     * @return unint32 ticket_id
     */
    int GetId(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->GetId());
        return 1;
    }

    /**
     * Return the [Player] from the [Ticket].
     *
     * @return [Player] player
     */
    int GetPlayer(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->GetPlayer());
        return 1;
    }

    /**
     * Return the [Player] name from the [Ticket].
     *
     * @return string player_name
     */
    int GetPlayerName(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->GetPlayerName());
        return 1;
    }

    /**
     * Returns the message sent in the [Ticket].
     *
     * @return string message
     */
    int GetMessage(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->GetMessage());
        return 1;
    }

    /**
     * Returns the assigned [Player].
     *
     * @return [Player] assigned_player
     */
    int GetAssignedPlayer(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->GetAssignedPlayer());
        return 1;
    }

    /**
     * Returns the assigned guid.
     *
     * @return [ObjectGUID] assigned_guid
     */
    int GetAssignedToGUID(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->GetAssignedToGUID());
        return 1;
    }

    /**
     * Returns the last modified time from the [Ticket].
     *
     * @return uint64 last_modified
     */
    int GetLastModifiedTime(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->GetLastModifiedTime());
        return 1;
    }

    /**
     * Assign the [Ticket] to a player via his GUID.
     *
     * @param guid playerGuid : desired playerGuid
     * @param bool isAdmin : true if the guid is an Admin or false (default false)
     */
    int SetAssignedTo(lua_State* L, GmTicket* ticket)
    {
        ObjectGuid guid = Eluna::CHECKVAL<ObjectGuid>(L, 2);
        bool is_admin = Eluna::CHECKVAL<bool>(L, 2, false);
        ticket->SetAssignedTo(guid, is_admin);
        return 0;
    }

    /**
     * Set [Ticket] resolved by player via his GUID.
     *
     * @param guid playerGuid : desired playerGuid
     */
    int SetResolvedBy(lua_State* L, GmTicket* ticket)
    {
        ObjectGuid guid = Eluna::CHECKVAL<ObjectGuid>(L, 2);
        ticket->SetResolvedBy(guid);
        return 0;
    }

    /**
     * Set [Ticket] completed.
     *
     */
    int SetCompleted(lua_State* /*L*/, GmTicket* ticket)
    {
        ticket->SetCompleted();
        return 0;
    }

    /**
     * Set [Ticket] message.
     *
     * @param string message: desired message
     *
     */
    int SetMessage(lua_State* L, GmTicket* ticket)
    {
        std::string message = Eluna::CHECKVAL<std::string>(L, 2);

        ticket->SetMessage(message);
        return 0;
    }

    /**
     * Set [Ticket] comment.
     *
     * @param string comment: desired comment
     *
     */
    int SetComment(lua_State* L, GmTicket* ticket)
    {
        std::string comment = Eluna::CHECKVAL<std::string>(L, 2);

        ticket->SetComment(comment);
        return 0;
    }

    /**
     * Set [Ticket] is viewed.
     *
     */
    int SetViewed(lua_State* /*L*/, GmTicket* ticket)
    {
        ticket->SetViewed();
        return 0;
    }

    /**
     * Set [Ticket] is unassigned.
     *
     */
    int SetUnassigned(lua_State* /*L*/, GmTicket* ticket)
    {
        ticket->SetUnassigned();
        return 0;
    }

    /**
     * Set the new [Ticket] creation position.
     *
     * @param uint32 mapId
     * @param float x
     * @param float y
     * @param float z
     *
     */
    int SetPosition(lua_State* L, GmTicket* ticket)
    {
        uint32 mapId = Eluna::CHECKVAL<uint32>(L, 2);
        float x = Eluna::CHECKVAL<float>(L, 2);
        float y = Eluna::CHECKVAL<float>(L, 2);
        float z = Eluna::CHECKVAL<float>(L, 2);

        ticket->SetPosition(mapId, x, y, z);
        return 0;
    }

    /**
     * Adds a response to the [Ticket].
     *
     * @param string response: desired response
     *
     */
    int AppendResponse(lua_State* L, GmTicket* ticket)
    {
        std::string response = Eluna::CHECKVAL<std::string>(L, 2);

        ticket->AppendResponse(response);
        return 0;
    }

    /**
     * Return the [Ticket] response.
     *
     * @return string response
     */
    int GetResponse(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->GetResponse());
        return 1;
    }

    /**
     * Delete the [Ticket] response.
     *
     */
    int DeleteResponse(lua_State* /*L*/, GmTicket* ticket)
    {
        ticket->DeleteResponse();
        return 0;
    }

    /**
     * Return the [Ticket] chatlog.
     *
     * @return string chatlog
     */
    int GetChatLog(lua_State* L, GmTicket* ticket)
    {
        Eluna::Push(L, ticket->GetChatLog());
        return 1;
    }
};
#endif


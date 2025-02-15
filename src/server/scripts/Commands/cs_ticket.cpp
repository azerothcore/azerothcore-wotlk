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

/* ScriptData
Name: ticket_commandscript
%Complete: 100
Comment: All ticket related commands
Category: commandscripts
EndScriptData */

#include "AccountMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Realm.h"
#include "TicketMgr.h"

using namespace Acore::ChatCommands;

class ticket_commandscript : public CommandScript
{
public:
    ticket_commandscript() : CommandScript("ticket_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable ticketResponseCommandTable =
        {
            { "append",         HandleGMTicketResponseAppendCommand,    SEC_GAMEMASTER,     Console::Yes },
            { "appendln",       HandleGMTicketResponseAppendLnCommand,  SEC_GAMEMASTER,     Console::Yes },
            { "delete",         HandleGMTicketResponseDeleteCommand,    SEC_GAMEMASTER,     Console::Yes },
            { "show",           HandleGMTicketResponseShowCommand,      SEC_GAMEMASTER,     Console::Yes }
        };
        static ChatCommandTable ticketCommandTable =
        {
            { "assign",         HandleGMTicketAssignToCommand,          SEC_GAMEMASTER,     Console::Yes },
            { "close",          HandleGMTicketCloseByIdCommand,         SEC_GAMEMASTER,     Console::Yes },
            { "closedlist",     HandleGMTicketListClosedCommand,        SEC_GAMEMASTER,     Console::Yes },
            { "comment",        HandleGMTicketCommentCommand,           SEC_GAMEMASTER,     Console::Yes },
            { "complete",       HandleGMTicketCompleteCommand,          SEC_GAMEMASTER,     Console::Yes },
            { "delete",         HandleGMTicketDeleteByIdCommand,        SEC_ADMINISTRATOR,  Console::Yes },
            { "escalate",       HandleGMTicketEscalateCommand,          SEC_GAMEMASTER,     Console::Yes },
            { "escalatedlist",  HandleGMTicketListEscalatedCommand,     SEC_GAMEMASTER,     Console::Yes },
            { "list",           HandleGMTicketListCommand,              SEC_GAMEMASTER,     Console::Yes },
            { "onlinelist",     HandleGMTicketListOnlineCommand,        SEC_GAMEMASTER,     Console::Yes },
            { "reset",          HandleGMTicketResetCommand,             SEC_CONSOLE,        Console::Yes },

            { "response",       ticketResponseCommandTable },
            { "togglesystem",   HandleToggleGMTicketSystem,             SEC_ADMINISTRATOR,  Console::Yes },
            { "unassign",       HandleGMTicketUnAssignCommand,          SEC_GAMEMASTER,     Console::Yes },
            { "viewid",         HandleGMTicketGetByIdCommand,           SEC_GAMEMASTER,     Console::Yes },
            { "viewname",       HandleGMTicketGetByNameCommand,         SEC_GAMEMASTER,     Console::Yes }
        };
        static ChatCommandTable commandTable =
        {
            { "ticket", ticketCommandTable }
        };
        return commandTable;
    }

    static bool HandleGMTicketAssignToCommand(ChatHandler* handler, uint32 ticketId, std::string target)
    {
        if (!normalizePlayerName(target))
            return false;

        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket || ticket->IsClosed())
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        // Get target information
        ObjectGuid targetGuid = sCharacterCache->GetCharacterGuidByName(target);
        uint32 targetAccountId = sCharacterCache->GetCharacterAccountIdByGuid(targetGuid);
        uint32 targetGmLevel = AccountMgr::GetSecurity(targetAccountId, realm.Id.Realm);

        // Target must exist and have administrative rights
        if (!targetGuid || AccountMgr::IsPlayerAccount(targetGmLevel))
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETASSIGNERROR_A);
            return true;
        }

        // If already assigned, leave
        if (ticket->IsAssignedTo(targetGuid))
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETASSIGNERROR_B, ticket->GetId());
            return true;
        }

        // If assigned to different player other than current, leave
        //! Console can override though
        Player* player = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;
        if (player && ticket->IsAssignedNotTo(player->GetGUID()))
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETALREADYASSIGNED, ticket->GetId(), target);
            return true;
        }

        // Assign ticket
        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->SetAssignedTo(targetGuid, AccountMgr::IsAdminAccount(targetGmLevel));
        ticket->SaveToDB(trans);
        sTicketMgr->UpdateLastChange(ticket);

        std::string msg = ticket->FormatMessageString(*handler, nullptr, target.c_str(), nullptr, nullptr);
        handler->SendGlobalGMSysMessage(msg.c_str());
        return true;
    }

    static bool HandleGMTicketCloseByIdCommand(ChatHandler* handler, uint32 ticketId)
    {
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket || ticket->IsClosed() || ticket->IsCompleted())
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        // Ticket should be assigned to the player who tries to close it.
        // Console can override though
        Player* player = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;
        if (player && ticket->IsAssignedNotTo(player->GetGUID()))
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETCANNOTCLOSE, ticket->GetId());
            return true;
        }

        sTicketMgr->ResolveAndCloseTicket(ticket->GetId(), player ? player->GetGUID() : ObjectGuid::Empty);
        sTicketMgr->UpdateLastChange(ticket);

        std::string msg = ticket->FormatMessageString(*handler, player ? player->GetName().c_str() : "Console", nullptr, nullptr, nullptr);
        handler->SendGlobalGMSysMessage(msg.c_str());

        // Inform player, who submitted this ticket, that it is closed
        if (Player* submitter = ticket->GetPlayer())
        {
            WorldPacket data(SMSG_GMTICKET_DELETETICKET, 4);
            data << uint32(GMTICKET_RESPONSE_TICKET_DELETED);
            submitter->GetSession()->SendPacket(&data);
            ChatHandler(submitter->GetSession()).SendSysMessage(LANG_TICKET_CLOSED);
        }
        return true;
    }

    static bool HandleGMTicketCommentCommand(ChatHandler* handler, uint32 ticketId, Tail comment)
    {
        if (comment.empty())
            return false;

        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket)
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        // Cannot comment ticket assigned to someone else (unless done from the Console)
        Player* player = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;
        if (player && ticket->IsAssignedNotTo(player->GetGUID()))
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETALREADYASSIGNED, ticket->GetId());
            return true;
        }

        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->SetComment(comment.data());
        ticket->SaveToDB(trans);
        sTicketMgr->UpdateLastChange(ticket);

        std::string const assignedName = ticket->GetAssignedToName();
        std::string msg = ticket->FormatMessageString(*handler, assignedName.empty() ? nullptr : assignedName.c_str(), nullptr, nullptr, nullptr);

        msg += handler->PGetParseString(LANG_COMMAND_TICKETLISTADDCOMMENT, player ? player->GetName().c_str() : "Console", comment.data());
        handler->SendGlobalGMSysMessage(msg.c_str());

        return true;
    }

    static bool HandleGMTicketListClosedCommand(ChatHandler* handler)
    {
        sTicketMgr->ShowClosedList(*handler);
        return true;
    }

    static bool HandleGMTicketCompleteCommand(ChatHandler* handler, uint32 ticketId)
    {
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket || ticket->IsClosed() || ticket->IsCompleted())
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        // Check if handler is not assignee in which case return
        Player* player = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;

        if (player && ticket->IsAssignedNotTo(player->GetGUID()))
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETALREADYASSIGNED, ticket->GetId());
            return true;
        }

        char* response = strtok(nullptr, "\n");
        if (response)
            ticket->AppendResponse(response);

        if (Player* player2 = ticket->GetPlayer())
        {
            ticket->SendResponse(player2->GetSession());
            ChatHandler(player2->GetSession()).SendSysMessage(LANG_TICKET_COMPLETED);
        }

        Player* gm = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;

        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->SetCompleted();
        ticket->SetResolvedBy(gm ? gm->GetGUID() : ObjectGuid::Empty);
        ticket->SaveToDB(trans);

        std::string msg = ticket->FormatMessageString(*handler, nullptr, nullptr, nullptr, nullptr);
        msg += handler->PGetParseString(LANG_COMMAND_TICKETCOMPLETED, gm ? gm->GetName().c_str() : "Console");
        handler->SendGlobalGMSysMessage(msg.c_str());
        sTicketMgr->UpdateLastChange(ticket);
        return true;
    }

    static bool HandleGMTicketDeleteByIdCommand(ChatHandler* handler, uint32 ticketId)
    {
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket)
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        if (!ticket->IsClosed())
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETCLOSEFIRST);
            return true;
        }

        std::string msg = ticket->FormatMessageString(*handler, nullptr, nullptr, nullptr, handler->GetSession() ? handler->GetSession()->GetPlayer()->GetName().c_str() : "Console");
        handler->SendGlobalGMSysMessage(msg.c_str());

        sTicketMgr->RemoveTicket(ticket->GetId());
        sTicketMgr->UpdateLastChange(ticket);

        if (Player* player = ticket->GetPlayer())
        {
            // Force abandon ticket
            WorldPacket data(SMSG_GMTICKET_DELETETICKET, 4);
            data << uint32(GMTICKET_RESPONSE_TICKET_DELETED);
            player->GetSession()->SendPacket(&data);
        }

        return true;
    }

    static bool HandleGMTicketEscalateCommand(ChatHandler* handler, uint32 ticketId)
    {
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket || ticket->IsClosed() || ticket->IsCompleted() || ticket->GetEscalatedStatus() != TICKET_UNASSIGNED)
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        ticket->SetEscalatedStatus(TICKET_IN_ESCALATION_QUEUE);

        if (Player* player = ticket->GetPlayer())
            sTicketMgr->SendTicket(player->GetSession(), ticket);

        sTicketMgr->UpdateLastChange(ticket);
        return true;
    }

    static bool HandleGMTicketListEscalatedCommand(ChatHandler* handler)
    {
        sTicketMgr->ShowEscalatedList(*handler);
        return true;
    }

    static bool HandleGMTicketListCommand(ChatHandler* handler)
    {
        sTicketMgr->ShowList(*handler, false);
        return true;
    }

    static bool HandleGMTicketListOnlineCommand(ChatHandler* handler)
    {
        sTicketMgr->ShowList(*handler, true);
        return true;
    }

    static bool HandleGMTicketResetCommand(ChatHandler* handler)
    {
        if (sTicketMgr->GetOpenTicketCount())
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETPENDING);
            return true;
        }
        else
        {
            sTicketMgr->ResetTickets();
            handler->SendSysMessage(LANG_COMMAND_TICKETRESET);
        }

        return true;
    }

    static bool HandleToggleGMTicketSystem(ChatHandler* handler)
    {
        bool status = !sTicketMgr->GetStatus();
        sTicketMgr->SetStatus(status);
        handler->PSendSysMessage(status ? LANG_ALLOW_TICKETS : LANG_DISALLOW_TICKETS);
        return true;
    }

    static bool HandleGMTicketUnAssignCommand(ChatHandler* handler, uint32 ticketId)
    {
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket || ticket->IsClosed())
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }
        // Ticket must be assigned
        if (!ticket->IsAssigned())
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETNOTASSIGNED, ticket->GetId());
            return true;
        }

        // Get security level of player, whom this ticket is assigned to
        uint32 security = SEC_PLAYER;
        Player* assignedPlayer = ticket->GetAssignedPlayer();
        if (assignedPlayer)
            security = assignedPlayer->GetSession()->GetSecurity();
        else
        {
            ObjectGuid guid = ticket->GetAssignedToGUID();
            uint32 accountId = sCharacterCache->GetCharacterAccountIdByGuid(guid);
            security = AccountMgr::GetSecurity(accountId, realm.Id.Realm);
        }

        // Check security
        //! If no m_session present it means we're issuing this command from the console
        uint32 mySecurity = handler->GetSession() ? handler->GetSession()->GetSecurity() : SEC_CONSOLE;
        if (security > mySecurity)
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETUNASSIGNSECURITY);
            return true;
        }

        std::string assignedTo = ticket->GetAssignedToName(); // copy assignedto name because we need it after the ticket has been unnassigned
        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->SetUnassigned();
        ticket->SaveToDB(trans);
        sTicketMgr->UpdateLastChange(ticket);

        std::string msg = ticket->FormatMessageString(*handler, nullptr, assignedTo.c_str(),
                          handler->GetSession() ? handler->GetSession()->GetPlayer()->GetName().c_str() : "Console", nullptr);
        handler->SendGlobalGMSysMessage(msg.c_str());

        return true;
    }

    static bool HandleGMTicketGetByIdCommand(ChatHandler* handler, uint32 ticketId)
    {
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket || ticket->IsClosed() || ticket->IsCompleted())
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->SetViewed();
        ticket->SaveToDB(trans);

        handler->SendSysMessage(ticket->FormatMessageString(*handler, true));
        return true;
    }

    static bool HandleGMTicketGetByNameCommand(ChatHandler* handler, std::string name)
    {
        if (!normalizePlayerName(name))
            return false;

        // Detect target's GUID
        ObjectGuid guid;
        if (Player* player = ObjectAccessor::FindPlayerByName(name, false))
        {
            guid = player->GetGUID();
        }
        else
        {
            guid = sCharacterCache->GetCharacterGuidByName(name);
        }

        // Target must exist
        if (!guid)
        {
            handler->SendSysMessage(LANG_NO_PLAYERS_FOUND);
            return true;
        }

        // Ticket must exist
        GmTicket* ticket = sTicketMgr->GetTicketByPlayer(guid);
        if (!ticket)
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->SetViewed();
        ticket->SaveToDB(trans);

        handler->SendSysMessage(ticket->FormatMessageString(*handler, true));
        return true;
    }

    static bool TicketResponseAppend(uint32 ticketId, bool newLine, ChatHandler* handler, std::string response)
    {
        if (response.empty())
            return false;

        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket || ticket->IsClosed())
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        // Cannot add response to ticket, assigned to someone else
        //! Console excluded
        Player* player = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;
        if (player && ticket->IsAssignedNotTo(player->GetGUID()))
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETALREADYASSIGNED, ticket->GetId());
            return true;
        }

        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        if (newLine)
            ticket->AppendResponse("\n");
        ticket->AppendResponse(response);
        ticket->SaveToDB(trans);
        sTicketMgr->UpdateLastChange(ticket);

        std::string msg = ticket->FormatMessageString(*handler, nullptr, nullptr, nullptr, nullptr);
        msg += handler->PGetParseString(LANG_COMMAND_TICKETRESPONSEAPPENDED, response);

        handler->PSendSysMessage(msg);
        return true;
    }

    static bool HandleGMTicketResponseAppendCommand(ChatHandler* handler, uint32 ticketId, Tail res)
    {
        return TicketResponseAppend(ticketId, false, handler, res.data());
    }

    static bool HandleGMTicketResponseAppendLnCommand(ChatHandler* handler, uint32 ticketId, Tail res)
    {
        return TicketResponseAppend(ticketId, true, handler, res.data());
    }

    static bool HandleGMTicketResponseDeleteCommand(ChatHandler* handler, uint32 ticketId)
    {
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        // Don't allow deleting response for a closed ticket.
        if (!ticket || ticket->IsClosed())
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        // Cannot delete response for a ticket that is assigned to someone else.
        //! Console excluded
        Player* player = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;
        if (player && ticket->IsAssignedNotTo(player->GetGUID()))
        {
            handler->PSendSysMessage(LANG_COMMAND_TICKETALREADYASSIGNED, ticket->GetId());
            return true;
        }

        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->DeleteResponse();
        ticket->SaveToDB(trans);
        sTicketMgr->UpdateLastChange(ticket);

        std::string msg = ticket->FormatMessageString(*handler, nullptr, nullptr, nullptr, nullptr);
        msg += handler->PGetParseString(LANG_COMMAND_TICKETRESPONSEDELETED, player ? player->GetName() : "Console");

        handler->SendGlobalGMSysMessage(msg.c_str());
        return true;
    }

    static bool HandleGMTicketResponseShowCommand(ChatHandler* handler, uint32 ticketId)
    {
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket)
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        std::string msg = ticket->FormatMessageString(*handler, nullptr, nullptr, nullptr, nullptr);
        msg += handler->PGetParseString(LANG_COMMAND_TICKETLISTRESPONSE, ticket->GetResponse());

        handler->PSendSysMessage(msg);
        return true;
    }
};

void AddSC_ticket_commandscript()
{
    new ticket_commandscript();
}

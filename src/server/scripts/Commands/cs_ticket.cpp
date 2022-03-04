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
#include "Language.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "Realm.h"
#include "ScriptMgr.h"
#include "TicketMgr.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class ticket_commandscript : public CommandScript
{
public:
    ticket_commandscript() : CommandScript("ticket_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable ticketResponseCommandTable =
        {
            { "append",         SEC_GAMEMASTER,      true,  &HandleGMTicketResponseAppendCommand,    "" },
            { "appendln",       SEC_GAMEMASTER,      true,  &HandleGMTicketResponseAppendLnCommand,  "" }
        };
        static ChatCommandTable ticketCommandTable =
        {
            { "assign",         SEC_GAMEMASTER,      true,  &HandleGMTicketAssignToCommand,          "" },
            { "close",          SEC_GAMEMASTER,      true,  &HandleGMTicketCloseByIdCommand,         "" },
            { "closedlist",     SEC_GAMEMASTER,      true,  &HandleGMTicketListClosedCommand,        "" },
            { "comment",        SEC_GAMEMASTER,      true,  &HandleGMTicketCommentCommand,           "" },
            { "complete",       SEC_GAMEMASTER,      true,  &HandleGMTicketCompleteCommand,          "" },
            { "delete",         SEC_ADMINISTRATOR,   true,  &HandleGMTicketDeleteByIdCommand,        "" },
            { "escalate",       SEC_GAMEMASTER,      true,  &HandleGMTicketEscalateCommand,          "" },
            { "escalatedlist",  SEC_GAMEMASTER,      true,  &HandleGMTicketListEscalatedCommand,     "" },
            { "list",           SEC_GAMEMASTER,      true,  &HandleGMTicketListCommand,              "" },
            { "onlinelist",     SEC_GAMEMASTER,      true,  &HandleGMTicketListOnlineCommand,        "" },
            { "reset",          SEC_CONSOLE,         true,  &HandleGMTicketResetCommand,             "" },
            { "response",       SEC_GAMEMASTER,      true,  nullptr,                                 "", ticketResponseCommandTable },
            { "togglesystem",   SEC_ADMINISTRATOR,   true,  &HandleToggleGMTicketSystem,             "" },
            { "unassign",       SEC_GAMEMASTER,      true,  &HandleGMTicketUnAssignCommand,          "" },
            { "viewid",         SEC_GAMEMASTER,      true,  &HandleGMTicketGetByIdCommand,           "" },
            { "viewname",       SEC_GAMEMASTER,      true,  &HandleGMTicketGetByNameCommand,         "" }
        };
        static ChatCommandTable commandTable =
        {
            { "ticket",         SEC_GAMEMASTER,      false, nullptr,                                 "", ticketCommandTable }
        };
        return commandTable;
    }

    static bool HandleGMTicketAssignToCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* ticketIdStr = strtok((char*)args, " ");
        uint32 ticketId = atoi(ticketIdStr);

        char* targetStr = strtok(nullptr, " ");
        if (!targetStr)
            return false;

        std::string target(targetStr);
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
        sTicketMgr->UpdateLastChange();

        std::string msg = ticket->FormatMessageString(*handler, nullptr, target.c_str(), nullptr, nullptr);
        handler->SendGlobalGMSysMessage(msg.c_str());
        return true;
    }

    static bool HandleGMTicketCloseByIdCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 ticketId = atoi(args);
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
        sTicketMgr->UpdateLastChange();

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

    static bool HandleGMTicketCommentCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* ticketIdStr = strtok((char*)args, " ");
        uint32 ticketId = atoi(ticketIdStr);

        char* comment = strtok(nullptr, "\n");
        if (!comment)
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
        ticket->SetComment(comment);
        ticket->SaveToDB(trans);
        sTicketMgr->UpdateLastChange();

        std::string const assignedName = ticket->GetAssignedToName();
        std::string msg = ticket->FormatMessageString(*handler, assignedName.empty() ? nullptr : assignedName.c_str(), nullptr, nullptr, nullptr);

        msg += handler->PGetParseString(LANG_COMMAND_TICKETLISTADDCOMMENT, player ? player->GetName().c_str() : "Console", comment);
        handler->SendGlobalGMSysMessage(msg.c_str());

        return true;
    }

    static bool HandleGMTicketListClosedCommand(ChatHandler* handler, char const* /*args*/)
    {
        sTicketMgr->ShowClosedList(*handler);
        return true;
    }

    static bool HandleGMTicketCompleteCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* ticketIdStr = strtok((char*)args, " ");
        uint32 ticketId = atoi(ticketIdStr);

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
        sTicketMgr->UpdateLastChange();
        return true;
    }

    static bool HandleGMTicketDeleteByIdCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 ticketId = atoi(args);
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
        sTicketMgr->UpdateLastChange();

        if (Player* player = ticket->GetPlayer())
        {
            // Force abandon ticket
            WorldPacket data(SMSG_GMTICKET_DELETETICKET, 4);
            data << uint32(GMTICKET_RESPONSE_TICKET_DELETED);
            player->GetSession()->SendPacket(&data);
        }

        return true;
    }

    static bool HandleGMTicketEscalateCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 ticketId = atoi(args);
        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket || ticket->IsClosed() || ticket->IsCompleted() || ticket->GetEscalatedStatus() != TICKET_UNASSIGNED)
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        ticket->SetEscalatedStatus(TICKET_IN_ESCALATION_QUEUE);

        if (Player* player = ticket->GetPlayer())
            sTicketMgr->SendTicket(player->GetSession(), ticket);

        sTicketMgr->UpdateLastChange();
        return true;
    }

    static bool HandleGMTicketListEscalatedCommand(ChatHandler* handler, char const* /*args*/)
    {
        sTicketMgr->ShowEscalatedList(*handler);
        return true;
    }

    static bool HandleGMTicketListCommand(ChatHandler* handler, char const* /*args*/)
    {
        sTicketMgr->ShowList(*handler, false);
        return true;
    }

    static bool HandleGMTicketListOnlineCommand(ChatHandler* handler, char const* /*args*/)
    {
        sTicketMgr->ShowList(*handler, true);
        return true;
    }

    static bool HandleGMTicketResetCommand(ChatHandler* handler, char const* /*args*/)
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

    static bool HandleToggleGMTicketSystem(ChatHandler* handler, char const* /*args*/)
    {
        bool status = !sTicketMgr->GetStatus();
        sTicketMgr->SetStatus(status);
        handler->PSendSysMessage(status ? LANG_ALLOW_TICKETS : LANG_DISALLOW_TICKETS);
        return true;
    }

    static bool HandleGMTicketUnAssignCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 ticketId = atoi(args);
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
        sTicketMgr->UpdateLastChange();

        std::string msg = ticket->FormatMessageString(*handler, nullptr, assignedTo.c_str(),
                          handler->GetSession() ? handler->GetSession()->GetPlayer()->GetName().c_str() : "Console", nullptr);
        handler->SendGlobalGMSysMessage(msg.c_str());

        return true;
    }

    static bool HandleGMTicketGetByIdCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 ticketId = atoi(args);
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

    static bool HandleGMTicketGetByNameCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        std::string name(args);
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

    static bool _HandleGMTicketResponseAppendCommand(char const* args, bool newLine, ChatHandler* handler)
    {
        if (!*args)
            return false;

        char* ticketIdStr = strtok((char*)args, " ");
        uint32 ticketId = atoi(ticketIdStr);

        char* response = strtok(nullptr, "\n");
        if (!response)
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
        ticket->AppendResponse(response);
        if (newLine)
            ticket->AppendResponse("\n");
        ticket->SaveToDB(trans);

        return true;
    }

    static bool HandleGMTicketResponseAppendCommand(ChatHandler* handler, char const* args)
    {
        return _HandleGMTicketResponseAppendCommand(args, false, handler);
    }

    static bool HandleGMTicketResponseAppendLnCommand(ChatHandler* handler, char const* args)
    {
        return _HandleGMTicketResponseAppendCommand(args, true, handler);
    }
};

void AddSC_ticket_commandscript()
{
    new ticket_commandscript();
}

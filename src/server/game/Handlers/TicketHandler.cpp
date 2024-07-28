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

#include "Chat.h"
#include "GameTime.h"
#include "Language.h"
#include "Opcodes.h"
#include "Player.h"
#include "TicketMgr.h"
#include "Util.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include <zlib.h>

void WorldSession::HandleGMTicketCreateOpcode(WorldPacket& recvData)
{
    // Don't accept tickets if the ticket queue is disabled. (Ticket UI is greyed out but not fully dependable)
    if (sTicketMgr->GetStatus() == GMTICKET_QUEUE_STATUS_DISABLED)
        return;

    if (GetPlayer()->GetLevel() < sWorld->getIntConfig(CONFIG_TICKET_LEVEL_REQ))
    {
        SendNotification(LANG_TICKET_REQ, sWorld->getIntConfig(CONFIG_TICKET_LEVEL_REQ));
        return;
    }

    GMTicketResponse response = GMTICKET_RESPONSE_CREATE_ERROR;
    GmTicket* ticket = sTicketMgr->GetTicketByPlayer(GetPlayer()->GetGUID());

    if (ticket && ticket->IsCompleted())
        sTicketMgr->CloseTicket(ticket->GetId(), GetPlayer()->GetGUID());

    // Player must not have ticket
    if (!ticket || ticket->IsClosed())
    {
        uint32 mapId;
        float x, y, z;
        std::string message;
        uint32 needResponse;
        bool needMoreHelp;
        uint32 count;
        std::list<uint32> times;
        uint32 decompressedSize;
        std::string chatLog;

        recvData >> mapId;
        recvData >> x >> y >> z;
        recvData >> message;

        if (!ValidateHyperlinksAndMaybeKick(message))
        {
            return;
        }

        recvData >> needResponse;
        recvData >> needMoreHelp;

        recvData >> count;

        for (uint32 i = 0; i < count; i++)
        {
            uint32 time;
            recvData >> time;
            times.push_back(time);
        }

        recvData >> decompressedSize;

        if (count && decompressedSize && decompressedSize < 0xFFFF)
        {
            uint32 pos = recvData.rpos();
            ByteBuffer dest;
            dest.resize(decompressedSize);

            uLongf realSize = decompressedSize;
            if (uncompress(dest.contents(), &realSize, recvData.contents() + pos, recvData.size() - pos) == Z_OK)
            {
                dest >> chatLog;
            }
            else
            {
                LOG_ERROR("network.opcode", "CMSG_GMTICKET_CREATE possibly corrupt. Uncompression failed.");
                recvData.rfinish();
                return;
            }

            recvData.rfinish(); // Will still have compressed data in buffer.
        }

        if (!chatLog.empty() && !ValidateHyperlinksAndMaybeKick(chatLog))
        {
            return;
        }

        ticket = new GmTicket(GetPlayer());
        ticket->SetPosition(mapId, x, y, z);
        ticket->SetMessage(message);
        ticket->SetGmAction(needResponse, needMoreHelp);

        if (!chatLog.empty())
            ticket->SetChatLog(times, chatLog);

        sTicketMgr->AddTicket(ticket);
        sTicketMgr->UpdateLastChange();

        ChatHandler(nullptr).SendGMText(LANG_COMMAND_TICKETNEW, GetPlayer()->GetName(), ticket->GetId());

        response = GMTICKET_RESPONSE_CREATE_SUCCESS;
    }

    WorldPacket data(SMSG_GMTICKET_CREATE, 4);
    data << uint32(response);
    SendPacket(&data);
}

void WorldSession::HandleGMTicketUpdateOpcode(WorldPacket& recv_data)
{
    std::string message;
    recv_data >> message;

    if (!ValidateHyperlinksAndMaybeKick(message))
    {
        return;
    }

    GMTicketResponse response = GMTICKET_RESPONSE_UPDATE_ERROR;
    if (GmTicket* ticket = sTicketMgr->GetTicketByPlayer(GetPlayer()->GetGUID()))
    {
        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->SetMessage(message);
        ticket->SaveToDB(trans);

        ChatHandler(nullptr).SendGMText(LANG_COMMAND_TICKETUPDATED, GetPlayer()->GetName(), ticket->GetId());

        response = GMTICKET_RESPONSE_UPDATE_SUCCESS;
    }

    WorldPacket data(SMSG_GMTICKET_UPDATETEXT, 4);
    data << uint32(response);
    SendPacket(&data);
}

void WorldSession::HandleGMTicketDeleteOpcode(WorldPacket& /*recv_data*/)
{
    if (GmTicket* ticket = sTicketMgr->GetTicketByPlayer(GetPlayer()->GetGUID()))
    {
        WorldPacket data(SMSG_GMTICKET_DELETETICKET, 4);
        data << uint32(GMTICKET_RESPONSE_TICKET_DELETED);
        SendPacket(&data);

        ChatHandler(nullptr).SendGMText(LANG_COMMAND_TICKETPLAYERABANDON, GetPlayer()->GetName(), ticket->GetId());

        sTicketMgr->CloseTicket(ticket->GetId(), GetPlayer()->GetGUID());
        sTicketMgr->SendTicket(this, nullptr);
    }
}

void WorldSession::HandleGMTicketGetTicketOpcode(WorldPacket& /*recv_data*/)
{
    SendQueryTimeResponse();

    if (GmTicket* ticket = sTicketMgr->GetTicketByPlayer(GetPlayer()->GetGUID()))
    {
        if (ticket->IsCompleted())
            ticket->SendResponse(this);
        else
            sTicketMgr->SendTicket(this, ticket);
    }
    else
        sTicketMgr->SendTicket(this, nullptr);
}

void WorldSession::HandleGMTicketSystemStatusOpcode(WorldPacket& /*recv_data*/)
{
    // Note: This only disables the ticket UI at client side and is not fully reliable
    // are we sure this is a uint32? Should ask Zor
    WorldPacket data(SMSG_GMTICKET_SYSTEMSTATUS, 4);
    data << uint32(sTicketMgr->GetStatus() ? GMTICKET_QUEUE_STATUS_ENABLED : GMTICKET_QUEUE_STATUS_DISABLED);
    SendPacket(&data);
}

void WorldSession::HandleGMSurveySubmit(WorldPacket& recv_data)
{
    uint32 nextSurveyID = sTicketMgr->GetNextSurveyID();
    // just put the survey into the database
    uint32 mainSurvey; // GMSurveyCurrentSurvey.dbc, column 1 (all 9) ref to GMSurveySurveys.dbc
    recv_data >> mainSurvey;

    std::unordered_set<uint32> surveyIds;
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    // sub_survey1, r1, comment1, sub_survey2, r2, comment2, sub_survey3, r3, comment3, sub_survey4, r4, comment4, sub_survey5, r5, comment5, sub_survey6, r6, comment6, sub_survey7, r7, comment7, sub_survey8, r8, comment8, sub_survey9, r9, comment9, sub_survey10, r10, comment10,
    for (uint8 i = 0; i < 10; i++)
    {
        uint32 subSurveyId; // ref to i'th GMSurveySurveys.dbc field (all fields in that dbc point to fields in GMSurveyQuestions.dbc)
        recv_data >> subSurveyId;
        if (!subSurveyId)
            break;

        uint8 rank; // probably some sort of ref to GMSurveyAnswers.dbc
        recv_data >> rank;
        std::string comment; // comment ("Usage: GMSurveyAnswerSubmit(question, rank, comment)")
        recv_data >> comment;

        if (!ValidateHyperlinksAndMaybeKick(comment))
        {
            return;
        }

        // make sure the same sub survey is not added to DB twice
        if (!surveyIds.insert(subSurveyId).second)
            continue;

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_GM_SUBSURVEY);
        stmt->SetData(0, nextSurveyID);
        stmt->SetData(1, subSurveyId);
        stmt->SetData(2, rank);
        stmt->SetData(3, comment);
        trans->Append(stmt);
    }

    std::string comment; // just a guess
    recv_data >> comment;

    if (!ValidateHyperlinksAndMaybeKick(comment))
    {
        return;
    }

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_GM_SURVEY);
    stmt->SetData(0, GetPlayer()->GetGUID().GetCounter());
    stmt->SetData(1, nextSurveyID);
    stmt->SetData(2, mainSurvey);
    stmt->SetData(3, comment);

    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);
}

void WorldSession::HandleReportLag(WorldPacket& recv_data)
{
    // just put the lag report into the database...
    // can't think of anything else to do with it
    uint32 lagType, mapId;
    recv_data >> lagType;
    recv_data >> mapId;
    float x, y, z;
    recv_data >> x;
    recv_data >> y;
    recv_data >> z;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_LAG_REPORT);
    stmt->SetData(0, GetPlayer()->GetGUID().GetCounter());
    stmt->SetData (1, lagType);
    stmt->SetData(2, mapId);
    stmt->SetData (3, x);
    stmt->SetData (4, y);
    stmt->SetData (5, z);
    stmt->SetData(6, GetLatency());
    stmt->SetData(7, GameTime::GetGameTime().count());
    CharacterDatabase.Execute(stmt);
}

void WorldSession::HandleGMResponseResolve(WorldPacket& /*recvPacket*/)
{
    // empty packet
    if (GmTicket* ticket = sTicketMgr->GetTicketByPlayer(GetPlayer()->GetGUID()))
    {
        uint8 getSurvey = 0;
        if (float(rand_chance()) < sWorld->getFloatConfig(CONFIG_CHANCE_OF_GM_SURVEY))
            getSurvey = 1;

        WorldPacket data(SMSG_GMRESPONSE_STATUS_UPDATE, 4);
        data << uint8(getSurvey);
        SendPacket(&data);

        WorldPacket data2(SMSG_GMTICKET_DELETETICKET, 4);
        data2 << uint32(GMTICKET_RESPONSE_TICKET_DELETED);
        SendPacket(&data2);

        sTicketMgr->CloseTicket(ticket->GetId(), GetPlayer()->GetGUID());
        sTicketMgr->SendTicket(this, nullptr);
    }
}

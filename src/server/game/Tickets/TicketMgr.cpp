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

#include "TicketMgr.h"
#include "CharacterCache.h"
#include "Chat.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Language.h"
#include "Log.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

inline float GetAge(uint64 t) { return float(GameTime::GetGameTime().count() - t) / DAY; }

///////////////////////////////////////////////////////////////////////////////////////////////////
// GM ticket
GmTicket::GmTicket() : _id(0), _type(TICKET_TYPE_OPEN), _posX(0), _posY(0), _posZ(0), _mapId(0), _createTime(0), _lastModifiedTime(0),
    _completed(false), _escalatedStatus(TICKET_UNASSIGNED), _viewed(false), _needResponse(false), _needMoreHelp(false) { }

GmTicket::GmTicket(Player* player) : _type(TICKET_TYPE_OPEN), _createTime(GameTime::GetGameTime().count()), _lastModifiedTime(GameTime::GetGameTime().count()),
    _completed(false), _escalatedStatus(TICKET_UNASSIGNED), _viewed(false), _needMoreHelp(false)
{
    _id = sTicketMgr->GenerateTicketId();
    _playerName = player->GetName();
    _playerGuid = player->GetGUID();
}

GmTicket::~GmTicket() { }

bool GmTicket::LoadFromDB(Field* fields)
{
    //  0    1        2       3       4          5        6      7     8     9          10            11         12         13       14        15         16        17        18         19
    // id, type, playerGuid, name, message, createTime, mapId, posX, posY, posZ, lastModifiedTime, closedBy, assignedTo, comment, response, completed, escalated, viewed, haveTicket, resolvedBy
    uint8 index = 0;
    _id                 = fields[  index].Get<uint32>();
    _type               = TicketType(fields[++index].Get<uint8>());
    _playerGuid         = ObjectGuid::Create<HighGuid::Player>(fields[++index].Get<uint32>());
    _playerName         = fields[++index].Get<std::string>();
    _message            = fields[++index].Get<std::string>();
    _createTime         = fields[++index].Get<uint32>();
    _mapId              = fields[++index].Get<uint16>();
    _posX               = fields[++index].Get<float>();
    _posY               = fields[++index].Get<float>();
    _posZ               = fields[++index].Get<float>();
    _lastModifiedTime   = fields[++index].Get<uint32>();
    _closedBy           = ObjectGuid::Create<HighGuid::Player>(fields[++index].Get<int32>());
    _assignedTo         = ObjectGuid::Create<HighGuid::Player>(fields[++index].Get<uint32>());
    _comment            = fields[++index].Get<std::string>();
    _response           = fields[++index].Get<std::string>();
    _completed          = fields[++index].Get<bool>();
    _escalatedStatus    = GMTicketEscalationStatus(fields[++index].Get<uint8>());
    _viewed             = fields[++index].Get<bool>();
    _needMoreHelp       = fields[++index].Get<bool>();
    _resolvedBy         = ObjectGuid::Create<HighGuid::Player>(fields[++index].Get<int32>());

    return true;
}

void GmTicket::SaveToDB(CharacterDatabaseTransaction trans) const
{
    //  0    1       2         3          4          5        6     7     8     9           10           11          12        13        14        15         16        17         18          19
    // id, type, playerGuid, name, description, createTime, mapId, posX, posY, posZ, lastModifiedTime, closedBy, assignedTo, comment, response, completed, escalated, viewed, needMoreHelp, resolvedBy
    uint8 index = 0;
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_GM_TICKET);
    stmt->SetData(  index, _id);
    stmt->SetData (++index, uint8(_type));
    stmt->SetData(++index, _playerGuid.GetCounter());
    stmt->SetData(++index, _playerName);
    stmt->SetData(++index, _message);
    stmt->SetData(++index, uint32(_createTime));
    stmt->SetData(++index, _mapId);
    stmt->SetData (++index, _posX);
    stmt->SetData (++index, _posY);
    stmt->SetData (++index, _posZ);
    stmt->SetData(++index, uint32(_lastModifiedTime));
    stmt->SetData (++index, int32(_closedBy.GetCounter()));
    stmt->SetData(++index, _assignedTo.GetCounter());
    stmt->SetData(++index, _comment);
    stmt->SetData(++index, _response);
    stmt->SetData  (++index, _completed);
    stmt->SetData (++index, uint8(_escalatedStatus));
    stmt->SetData  (++index, _viewed);
    stmt->SetData  (++index, _needMoreHelp);
    stmt->SetData (++index, int32(_resolvedBy.GetCounter()));

    CharacterDatabase.ExecuteOrAppend(trans, stmt);
}

void GmTicket::DeleteFromDB()
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GM_TICKET);
    stmt->SetData(0, _id);
    CharacterDatabase.Execute(stmt);
}

void GmTicket::WritePacket(WorldPacket& data) const
{
    data << uint32(GMTICKET_STATUS_HASTEXT);
    data << uint32(_id);
    data << _message;
    data << uint8(_needMoreHelp);
    data << GetAge(_lastModifiedTime);
    if (GmTicket* ticket = sTicketMgr->GetOldestOpenTicket())
        data << GetAge(ticket->GetLastModifiedTime());
    else
        data << float(0);

    // I am not sure how blizzlike this is, and we don't really have a way to find out
    data << GetAge(sTicketMgr->GetLastChange());

    data << uint8(std::min(_escalatedStatus, TICKET_IN_ESCALATION_QUEUE));                              // escalated data
    data << uint8(_viewed ? GMTICKET_OPENEDBYGM_STATUS_OPENED : GMTICKET_OPENEDBYGM_STATUS_NOT_OPENED); // whether or not it has been viewed
}

void GmTicket::SendResponse(WorldSession* session) const
{
    WorldPacket data(SMSG_GMRESPONSE_RECEIVED);
    data << uint32(1);          // responseID
    data << uint32(_id);        // ticketID
    data << _message.c_str();

    std::size_t len = _response.size();
    char const* s = _response.c_str();

    for (int i = 0; i < 4; i++)
    {
        if (len)
        {
            std::size_t writeLen = std::min<size_t>(len, 3999);
            data.append(s, writeLen);

            len -= writeLen;
            s += writeLen;
        }

        data << uint8(0);
    }

    session->SendPacket(&data);
}

std::string GmTicket::FormatMessageString(ChatHandler& handler, bool detailed) const
{
    time_t curTime = GameTime::GetGameTime().count();

    std::stringstream ss;
    ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTGUID, _id);
    ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTNAME, _playerName.c_str());
    ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTAGECREATE, (secsToTimeString(curTime - _createTime, true)).c_str());
    ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTAGE, (secsToTimeString(curTime - _lastModifiedTime, true)).c_str());

    std::string name;
    if (sCharacterCache->GetCharacterNameByGuid(_assignedTo, name))
    {
        ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTASSIGNEDTO, name.c_str());
    }

    if (detailed)
    {
        ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTMESSAGE, _message.c_str());
        if (!_comment.empty())
            ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTCOMMENT, _comment.c_str());
        if (!_response.empty())
            ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTRESPONSE, _response.c_str());
    }
    return ss.str();
}

std::string GmTicket::FormatMessageString(ChatHandler& handler, const char* szClosedName, const char* szAssignedToName, const char* szUnassignedName, const char* szDeletedName) const
{
    std::stringstream ss;
    ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTGUID, _id);
    ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTNAME, _playerName.c_str());
    if (szClosedName)
        ss << handler.PGetParseString(LANG_COMMAND_TICKETCLOSED, szClosedName);
    if (szAssignedToName)
        ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTASSIGNEDTO, szAssignedToName);
    if (szUnassignedName)
        ss << handler.PGetParseString(LANG_COMMAND_TICKETLISTUNASSIGNED, szUnassignedName);
    if (szDeletedName)
        ss << handler.PGetParseString(LANG_COMMAND_TICKETDELETED, szDeletedName);
    return ss.str();
}

void GmTicket::SetUnassigned()
{
    _assignedTo.Clear();

    switch (_escalatedStatus)
    {
        case TICKET_ASSIGNED:
            _escalatedStatus = TICKET_UNASSIGNED;
            break;
        case TICKET_ESCALATED_ASSIGNED:
            _escalatedStatus = TICKET_IN_ESCALATION_QUEUE;
            break;
        case TICKET_UNASSIGNED:
        case TICKET_IN_ESCALATION_QUEUE:
        default:
            break;
    }
}

void GmTicket::SetPosition(uint32 mapId, float x, float y, float z)
{
    _mapId = mapId;
    _posX = x;
    _posY = y;
    _posZ = z;
}

void GmTicket::SetGmAction(uint32 needResponse, bool needMoreHelp)
{
    _needResponse = (needResponse == 17);   // Requires GM response. 17 = true, 1 = false (17 is default)
    _needMoreHelp = needMoreHelp;           // Requests further GM interaction on a ticket to which a GM has already responded. Basically means "has a new ticket"
}

void GmTicket::TeleportTo(Player* player) const
{
    player->TeleportTo(_mapId, _posX, _posY, _posZ, 0.0f, 0);
}

void GmTicket::SetChatLog(std::list<uint32> time, std::string const& log)
{
    std::stringstream ss(log);
    std::stringstream newss;
    std::string line;
    while (std::getline(ss, line) && !time.empty())
    {
        newss << secsToTimeString(time.front()) << ": " << line << "\n";
        time.pop_front();
    }

    _chatLog = newss.str();
}

void GmTicket::SetMessage(std::string const& message)
{
    _message = message;
    _lastModifiedTime = uint64(GameTime::GetGameTime().count());
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Ticket manager
TicketMgr::TicketMgr() : _status(true), _lastTicketId(0), _lastSurveyId(0), _openTicketCount(0), _lastChange(GameTime::GetGameTime().count()) { }

TicketMgr::~TicketMgr()
{
    for (GmTicketList::const_iterator itr = _ticketList.begin(); itr != _ticketList.end(); ++itr)
        delete itr->second;
}

TicketMgr* TicketMgr::instance()
{
    static TicketMgr instance;
    return &instance;
}

void TicketMgr::Initialize() { SetStatus(sWorld->getBoolConfig(CONFIG_ALLOW_TICKETS)); }

void TicketMgr::ResetTickets()
{
    for (GmTicketList::const_iterator itr = _ticketList.begin(); itr != _ticketList.end();)
    {
        if (itr->second->IsClosed())
        {
            uint32 ticketId = itr->second->GetId();
            ++itr;
            RemoveTicket(ticketId);
        }
        else
            ++itr;
    }

    _lastTicketId = 0;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ALL_GM_TICKETS);

    CharacterDatabase.Execute(stmt);
}

void TicketMgr::LoadTickets()
{
    uint32 oldMSTime = getMSTime();

    for (GmTicketList::const_iterator itr = _ticketList.begin(); itr != _ticketList.end(); ++itr)
        delete itr->second;
    _ticketList.clear();

    _lastTicketId = 0;
    _openTicketCount = 0;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GM_TICKETS);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 GM tickets. DB table `gm_ticket` is empty!");

        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        GmTicket* ticket = new GmTicket();
        if (!ticket->LoadFromDB(fields))
        {
            delete ticket;
            continue;
        }
        if (!ticket->IsClosed())
            ++_openTicketCount;

        // Update max ticket id if necessary
        uint32 id = ticket->GetId();
        if (_lastTicketId < id)
            _lastTicketId = id;

        _ticketList[id] = ticket;
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} GM tickets in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void TicketMgr::LoadSurveys()
{
    // we don't actually load anything into memory here as there's no reason to
    _lastSurveyId = 0;

    uint32 oldMSTime = getMSTime();
    if (QueryResult result = CharacterDatabase.Query("SELECT MAX(surveyId) FROM gm_survey"))
        _lastSurveyId = (*result)[0].Get<uint32>();

    LOG_INFO("server.loading", ">> Loaded GM Survey count from database in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void TicketMgr::AddTicket(GmTicket* ticket)
{
    _ticketList[ticket->GetId()] = ticket;
    if (!ticket->IsClosed())
        ++_openTicketCount;
    CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
    ticket->SaveToDB(trans);

    sScriptMgr->OnTicketCreate(ticket);
}

void TicketMgr::CloseTicket(uint32 ticketId, ObjectGuid source)
{
    if (GmTicket* ticket = GetTicket(ticketId))
    {
        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->SetClosedBy(source);
        if (source)
            --_openTicketCount;
        ticket->SaveToDB(trans);

        sScriptMgr->OnTicketClose(ticket);
    }
}

void TicketMgr::RemoveTicket(uint32 ticketId)
{
    if (GmTicket* ticket = GetTicket(ticketId))
    {
        ticket->DeleteFromDB();
        _ticketList.erase(ticketId);
        delete ticket;
    }
}

void TicketMgr::ResolveAndCloseTicket(uint32 ticketId, ObjectGuid source)
{
    if (GmTicket* ticket = GetTicket(ticketId))
    {
        CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr);
        ticket->SetClosedBy(source);
        ticket->SetResolvedBy(source);
        if (source)
            --_openTicketCount;
        ticket->SaveToDB(trans);

        sScriptMgr->OnTicketResolve(ticket);
    }
}

void TicketMgr::ShowList(ChatHandler& handler, bool onlineOnly) const
{
    handler.SendSysMessage(onlineOnly ? LANG_COMMAND_TICKETSHOWONLINELIST : LANG_COMMAND_TICKETSHOWLIST);
    for (GmTicketList::const_iterator itr = _ticketList.begin(); itr != _ticketList.end(); ++itr)
        if (!itr->second->IsClosed() && !itr->second->IsCompleted())
            if (!onlineOnly || itr->second->GetPlayer())
                handler.SendSysMessage(itr->second->FormatMessageString(handler).c_str());
}

void TicketMgr::ShowClosedList(ChatHandler& handler) const
{
    handler.SendSysMessage(LANG_COMMAND_TICKETSHOWCLOSEDLIST);
    for (GmTicketList::const_iterator itr = _ticketList.begin(); itr != _ticketList.end(); ++itr)
        if (itr->second->IsClosed())
            handler.SendSysMessage(itr->second->FormatMessageString(handler).c_str());
}

void TicketMgr::ShowEscalatedList(ChatHandler& handler) const
{
    handler.SendSysMessage(LANG_COMMAND_TICKETSHOWESCALATEDLIST);
    for (GmTicketList::const_iterator itr = _ticketList.begin(); itr != _ticketList.end(); ++itr)
        if (!itr->second->IsClosed() && itr->second->GetEscalatedStatus() == TICKET_IN_ESCALATION_QUEUE)
            handler.SendSysMessage(itr->second->FormatMessageString(handler).c_str());
}

void TicketMgr::SendTicket(WorldSession* session, GmTicket* ticket) const
{
    WorldPacket data(SMSG_GMTICKET_GETTICKET, (ticket ? (4 + 4 + 1 + 4 + 4 + 4 + 1 + 1) : 4));

    if (ticket)
        ticket->WritePacket(data);
    else
        data << uint32(GMTICKET_STATUS_DEFAULT);

    session->SendPacket(&data);
}

void TicketMgr::UpdateLastChange(GmTicket* ticket)
{
    _lastChange = GameTime::GetGameTime().count();

    sScriptMgr->OnTicketUpdateLastChange(ticket);
}

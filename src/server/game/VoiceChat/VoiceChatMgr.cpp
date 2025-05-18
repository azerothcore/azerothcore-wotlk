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

#include "VoiceChatMgr.h"
#include "AsyncConnector.h"
#include "BattlegroundMgr.h"
#include "ChannelMgr.h"
#include "Chat.h"
#include "GroupMgr.h"
#include "Log.h"
#include "Player.h"
#include "SharedDefines.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"
// #include "Chat/ChannelMgr.h"
// #include "BattleGround/BattleGroundMgr.h"
// #include "World/World.h"
// #include "Config/Config.h"

// #include "Network/AsyncConnector.hpp"
// #include <boost/thread/thread.hpp>
// #include <memory>
#include <boost/asio.hpp>
#include <thread>

using boost::asio::ip::tcp;

namespace {
// Helper function moved to anonymous namespace to avoid global scope pollution
void VoiceSocketThreadHelper() { sVoiceChatMgr.VoiceSocketThread(); }
} // namespace

void VoiceChatMgr::ActivateVoiceSocketThread() {
  std::thread t(VoiceSocketThreadHelper);
  t.detach();
}

void VoiceChatMgr::VoiceSocketThread() {
  try {
    // Create IO context and resolver
    boost::asio::io_context ioContext;
    tcp::resolver resolver(ioContext);

    // Get connection details
    std::string address = GetVoiceServerConnectAddressString();
    std::string port = std::to_string(GetVoiceServerConnectPort());

    LOG_ERROR("sql.sql", "Attempting to connect to voice server at {}:{}",
              address, port);

    // Resolve endpoint
    boost::system::error_code resolveError;
    auto endpoints = resolver.resolve(address, port, resolveError);

    if (resolveError) {
      LOG_ERROR("sql.sql", "Failed to resolve voice server address: {}",
                resolveError.message());
      return;
    }

    // Create and connect socket
    tcp::socket socket(ioContext);
    boost::system::error_code connectError;
    boost::asio::connect(socket, endpoints, connectError);

    if (connectError) {
      LOG_ERROR("sql.sql", "Failed to connect to voice server: {}",
                connectError.message());
      return;
    }

    LOG_ERROR("sql.sql", "Successfully connected to voice server");

    // Create voice chat session
    m_socket = std::make_shared<VoiceChatSocket>(std::move(socket));

    // Start processing
    if (m_socket) {
      m_socket->Start();
      ioContext.run();
    } else {
      LOG_ERROR("sql.sql", "Failed to create voice chat session");
    }
  } catch (const boost::system::system_error &e) {
    LOG_ERROR("sql.sql", "Boost system error in voice chat thread: {}",
              e.what());
  } catch (const std::exception &e) {
    LOG_ERROR("sql.sql", "Exception in voice chat thread: {}", e.what());
  } catch (...) {
    LOG_ERROR("sql.sql", "Unknown exception in voice chat thread");
  }
}

void VoiceChatMgr::LoadConfigs() {
  enabled = sWorld->getBoolConfig(CONFIG_VOICE_CHAT_ENABLED);

  server_address_string = sConfigMgr->GetOption<std::string>("VoiceChat.ServerAddress", "127.0.0.1");
  server_address = inet_addr(server_address_string.c_str());
  server_port = sWorld->getIntConfig(CONFIG_VOICE_CHAT_SERVER_PORT);

  std::string voice_address_string = sConfigMgr->GetOption<std::string>("VoiceChat.VoiceAddress", "127.0.0.1");
  voice_address = inet_addr(voice_address_string.c_str());
  voice_port = sWorld->getIntConfig(CONFIG_VOICE_CHAT_VOICE_PORT);

  maxConnectAttempts = sWorld->getIntConfig(CONFIG_VOICE_CHAT_MAX_CONNECT_ATTEMPTS);
}

void VoiceChatMgr::Init(Acore::Asio::IoContext &ioContext) {
  LoadConfigs();

  next_ping = std::chrono::system_clock::now() + std::chrono::seconds(5);
  last_pong = std::chrono::system_clock::now();
  lastUpdate = std::chrono::system_clock::now();
  curReconnectAttempts = 0;

  state = enabled ? VOICECHAT_NOT_CONNECTED : VOICECHAT_DISCONNECTED;

  // Attempt an asynchronous connection to the voice server
  LOG_ERROR("sql.sql", "Connecting to voice server at {}:{}",
            server_address_string, server_port);
  new AsyncConnector<VoiceChatSocket>(ioContext, server_address_string,
                                      server_port, false);

  // FIX: Store the connector
  _connector = std::make_unique<AsyncConnector<VoiceChatSocket>>(
      ioContext, server_address_string, server_port, false);

  // Optionally store a reference to ioContext in VoiceChatMgr if needed
}

void VoiceChatMgr::Update() {
  if (!enabled)
    return;

 LOG_ERROR("sql.sql", "VoiceChatMgr::Update state: {}", state);

  m_eventEmitter(this);

  if (m_socket)
    m_socket->Update(); // yep, that's it

  std::deque<std::unique_ptr<VoiceChatServerPacket>> recvQueueCopy;
  {
    std::lock_guard<std::mutex> guard(m_recvQueueLock);
    std::swap(recvQueueCopy, m_recvQueue);
  }

  while (m_socket && m_socket->IsOpen() && !recvQueueCopy.empty()) {
    auto const packet = std::move(recvQueueCopy.front());
    recvQueueCopy.pop_front();

    try {
      LOG_ERROR(
          "sql.sql",
          "VoiceChatMgr::Update Read Pong packet sent from server"); // Log info
                                                                     // for pong
                                                                     // packets
      HandleVoiceChatServerPacket(*packet);
    } catch (const ByteBufferException &) {
      LOG_ERROR("sql.sql", "VoiceChatMgr::Update EXCEPTION Read Pong packet "
                           "sent from server"); // Log info for pong packets
      ProcessByteBufferException(*packet);
    }
  }

  if (state == VOICECHAT_DISCONNECTED)
    return;

  auto now = std::chrono::system_clock::now();
  if (now - lastUpdate < std::chrono::seconds(1))
    return;

  lastUpdate = now;

  if (m_requestSocket) {
    m_socket = m_requestSocket;
    m_requestSocket = nullptr;
    return;
  }

  // connecting / reconnecting
  if (!m_socket) {
    if (state == VOICECHAT_CONNECTED) {
      LOG_ERROR("sql.sql", "VoiceChatMgr: !m_socket but connected -> Socket disconnected");
      SocketDisconnected();
      SendVoiceChatServiceDisconnect();
      state = VOICECHAT_RECONNECTING;
      next_connect =
          std::chrono::system_clock::now() + std::chrono::seconds(10);
      return;
    }

    if (state == VOICECHAT_RECONNECTING) {
      if (maxConnectAttempts >= 0 &&
          curReconnectAttempts >= maxConnectAttempts) {
        if (maxConnectAttempts > 0)
          LOG_ERROR(
              "sql.sql",
              "VoiceChatMgr: Disconnected! Max reconnect attempts reached");
        else
          LOG_ERROR("sql.sql",
                    "VoiceChatMgr: Disconnected! Reconnecting disabled");

        DeleteAllChannels();
        SendVoiceChatStatus(false);
        SendVoiceChatServiceConnectFail();
        curReconnectAttempts = 0;
        state = VOICECHAT_DISCONNECTED;
        return;
      }
    }

    if (now > next_connect) {
      if (NeedConnect() || NeedReconnect()) {
        ActivateVoiceSocketThread();
      }

      if (curReconnectAttempts > 0) {
        if (state == VOICECHAT_NOT_CONNECTED)
          LOG_ERROR("sql.sql",
                    "VoiceChatMgr: Connect failed, will try again later");
        if (state == VOICECHAT_RECONNECTING)
          LOG_ERROR("sql.sql",
                    "VoiceChatMgr: Reconnect failed, will try again later");
      }

      if (state == VOICECHAT_NOT_CONNECTED || state == VOICECHAT_RECONNECTING)
        curReconnectAttempts++;

      next_connect = now + std::chrono::seconds(10);
      return;
    }
  } else {
    if (!m_socket->IsOpen()) {
      if (state == VOICECHAT_CONNECTED) {
        LOG_ERROR("sql.sql", "VoiceChatMgr: !open but connected -> Socket disconnected");
        SocketDisconnected();
        SendVoiceChatServiceDisconnect();
        state = VOICECHAT_RECONNECTING;
        return;
      }

      if (now > next_connect) {
        if (!m_requestSocket && (state == VOICECHAT_NOT_CONNECTED ||
                                 state == VOICECHAT_RECONNECTING)) {
          ActivateVoiceSocketThread();
          next_connect = now + std::chrono::seconds(5);
        }
      }
      return;
    }

    // socket is open
    if (state == VOICECHAT_NOT_CONNECTED || state == VOICECHAT_RECONNECTING) {
      if (state == VOICECHAT_NOT_CONNECTED)
        LOG_ERROR("sql.sql", "VoiceChatMgr: Connected to {}:{}.",
                  m_socket->GetRemoteIpAddress().to_string(),
                  m_socket->GetRemotePort());
      if (state == VOICECHAT_RECONNECTING)
        LOG_ERROR("sql.sql", "VoiceChatMgr: Reconnected to {}:{}",
                  m_socket->GetRemoteIpAddress().to_string(),
                  m_socket->GetRemotePort());

      SendVoiceChatStatus(true);
      RestoreVoiceChatChannels();
      if (state == VOICECHAT_RECONNECTING) {
        SendVoiceChatServiceReconnected();
      }

      state = VOICECHAT_CONNECTED;
      curReconnectAttempts = 0;
      last_pong = now;
    } else {
      if (now >= next_ping) {
        LOG_ERROR("sql.sql", "VoiceChatMgr: Sending ping");
        next_ping = now + std::chrono::seconds(5);
        VoiceChatServerPacket data(VOICECHAT_CMSG_PING, 4);
        data << uint32(0);
        m_socket->SendPacket(data);
      }

      if (m_socket && (now - last_pong) > std::chrono::seconds(10)) {
        LOG_ERROR("sql.sql", "VoiceChatMgr: Ping timeout!");
        SocketDisconnected();
        // SendVoiceChatServiceDisconnect();
        state = VOICECHAT_RECONNECTING;
        // next_connect = now + std::chrono::seconds(10);
      }
    }
  }
}

void VoiceChatMgr::HandleVoiceChatServerPacket(VoiceChatServerPacket &pck) {

  uint32 request_id;
  uint8 error;
  uint16 channel_id;

  LOG_ERROR("sql.sql", "VoiceChatMgr::HandleVoiceChatServerPacket Received {}", pck.GetOpcode());

  switch (pck.GetOpcode()) {
  case VOICECHAT_SMSG_PONG: {
    last_pong = std::chrono::system_clock::now();
    break;
  }
  case VOICECHAT_SMSG_CHANNEL_CREATED: {
    pck >> request_id;
    pck >> error;

    for (auto request = m_requests.begin(); request != m_requests.end();) {
      if (request->id == request_id) {
        if (error == 0) {
          pck >> channel_id;
        } else {
          LOG_ERROR("sql.sql", "VoiceChatMgr: Error creating voice channel");
          request = m_requests.erase(request);
          return;
        }

        if (request->groupid) {
          if (request->type == VOICECHAT_CHANNEL_GROUP || request->type ==
          VOICECHAT_CHANNEL_RAID)
          {
              Group* grp = sGroupMgr->GetGroupByGUID(request->groupid);
              if (grp)
              {
                  auto* v_channel = new
                  VoiceChatChannel(VoiceChatChannelTypes(request->type),
                  channel_id, grp->GetId());
                  m_VoiceChatChannels.insert(std::make_pair((uint32)channel_id,
                  v_channel)); v_channel->AddMembersAfterCreate();
              }
          }
          else if (request->type == VOICECHAT_CHANNEL_BG)
          {
              Battleground* bg = sBattlegroundMgr->GetBattleground(request->groupid,
              BATTLEGROUND_TYPE_NONE); if (bg)
              {
                  // for BG use bg's instanceID as groupID
                  auto* v_channel = new
                  VoiceChatChannel(VoiceChatChannelTypes(request->type),
                  channel_id, request->groupid, "", request->team);
                  m_VoiceChatChannels.insert(std::make_pair((uint32)channel_id,
                  v_channel)); v_channel->AddMembersAfterCreate();
              }
          }
        } else if (request->type == VOICECHAT_CHANNEL_CUSTOM) {
          if (ChannelMgr* cMgr = ChannelMgr::forTeam(request->team))
          {
              Channel* chan = cMgr->GetChannel(request->channel_name,
              nullptr, false); if (chan)
              {
                  auto* v_channel = new
                  VoiceChatChannel(VoiceChatChannelTypes(request->type),
                  channel_id, 0, request->channel_name, request->team);
                  m_VoiceChatChannels.insert(std::make_pair((uint32)channel_id,
                  v_channel)); v_channel->AddMembersAfterCreate();
              }
          }
        }

        request = m_requests.erase(request);
      } else
        request++;
    }
    break;
  }
  default: {
    LOG_ERROR("sql.sql", "VoiceChatMgr: received unknown opcode {}!\n",
              pck.GetOpcode());
    break;
  }
  }
}
//
void VoiceChatMgr::SocketDisconnected() {
  // sLog->outBasic("VoiceChatMgr: VoiceChatServerSocket disconnected");
  LOG_ERROR("sql.sql", "VoiceChatMgr: VoiceChatServerSocket disconnected");

// we close somewher eelse
//   if (m_socket) {
    // if (m_socket->IsOpen())
    //   m_socket->CloseSocket();
//   }

  // m_socket.reset();
  // m_voiceService.stop();
  // m_socket = nullptr;
  m_requests.clear();

  DeleteAllChannels();

  curReconnectAttempts = 0;
}

bool VoiceChatMgr::NeedConnect() {
  return enabled && !m_socket && !m_requestSocket &&
         state == VOICECHAT_NOT_CONNECTED &&
         std::chrono::system_clock::now() > next_connect;
}

bool VoiceChatMgr::NeedReconnect() {
  return enabled && !m_socket && !m_requestSocket &&
         state == VOICECHAT_RECONNECTING &&
         std::chrono::system_clock::now() > next_connect;
}

int32 VoiceChatMgr::GetReconnectAttempts() const {
  if (maxConnectAttempts < 0 ||
      (maxConnectAttempts > 0 && curReconnectAttempts < maxConnectAttempts)) {
    return maxConnectAttempts;
  }

  return 0;
}

bool VoiceChatMgr::RequestNewSocket(VoiceChatSocket* socket)
{
    if (m_requestSocket)
        return false;

    m_requestSocket = socket->shared_from_this();
    return true;
}

// Add an incoming packet to the queue
void VoiceChatMgr::QueuePacket(
    std::unique_ptr<VoiceChatServerPacket> new_packet) {
  std::lock_guard<std::mutex> guard(m_recvQueueLock);
  m_recvQueue.push_back(std::move(new_packet));
}
//
void VoiceChatMgr::ProcessByteBufferException(
    VoiceChatServerPacket const &packet) {
  LOG_ERROR("sql.sql",
            "VoiceChatMgr::Update ByteBufferException occured while parsing a "
            "packet (opcode: {}).",
            packet.GetOpcode());

  // if (sLog->HasLogLevelOrHigher(LOG_LVL_DEBUG))
  {
    // DEBUG_LOG("Dumping error-causing voice server packet:");
    LOG_ERROR("sql.sql", "Dumping error-causing voice server packet:");
    packet.hexlike();
  }

  LOG_ERROR(
      "sql.sql",
      "Disconnecting voice server [address {}] for badly formatted packet.",
      GetVoiceServerConnectAddressString());
  // DETAIL_LOG("Disconnecting voice server [address {}] for badly formatted
  // packet.",
  //    );

  // Replace Messager with EventEmitter callback
  m_eventEmitter += [](VoiceChatMgr *mgr) { mgr->SocketDisconnected(); };
}
//
// void VoiceChatMgr::VoiceSocketThread()
// {
//     m_voiceService.stop();
//     m_voiceService.restart();
//     std::unique_ptr<MaNGOS::AsyncConnector<VoiceChatServerSocket>>
//     voiceSocket; voiceSocket =
//     std::make_unique<MaNGOS::AsyncConnector<VoiceChatServerSocket>>(m_voiceService,
//     sVoiceChatMgr.GetVoiceServerConnectAddressString(),
//     int32(sVoiceChatMgr.GetVoiceServerConnectPort()), false);
//     m_voiceService.run();
// }
//
// enabled and connected to voice server
bool VoiceChatMgr::CanUseVoiceChat()
{
    return (enabled && m_socket);
}

// enabled and is connected or trying to connect to voice server
bool VoiceChatMgr::CanSeeVoiceChat()
{
    return (enabled && state != VOICECHAT_DISCONNECTED);
}

void VoiceChatMgr::CreateVoiceChatChannel(VoiceChatChannelTypes type, uint32
groupId, const std::string& name, TeamId team)
{
    if (!m_socket)
        return;

    if (type == VOICECHAT_CHANNEL_NONE)
        return;

    if (!groupId && name.empty())
        return;

    TeamId newTeam = GetCustomChannelTeam(team);

    if (IsVoiceChatChannelBeingCreated(type, groupId, name, newTeam))
        return;

    LOG_ERROR("sql.sql", "VoiceChatMgr: CreateVoiceChannel type: {}, name: {}, team: {}, group: {}", type, name.c_str(), newTeam, groupId);
    VoiceChatChannelRequest req;
    req.id = new_request_id++;
    req.type = type;
    req.channel_name = name;
    req.team = newTeam;
    req.groupid = groupId;
    m_requests.push_back(req);

    VoiceChatServerPacket data(VOICECHAT_CMSG_CREATE_CHANNEL, 5);
    data << req.type;
    data << req.id;
    m_socket->SendPacket(data);
}
//
void VoiceChatMgr::DeleteVoiceChatChannel(VoiceChatChannel *channel) {
  if (!channel)
      return;

   LOG_ERROR("sql.sql", "VoiceChatMgr: DeleteVoiceChannel id: {} type: {}", channel->GetChannelId(), channel->GetType());

  uint8 type = channel->GetType();
  uint16 id = channel->GetChannelId();

  // disable voice in custom channel
  if (type == VOICECHAT_CHANNEL_CUSTOM)
  {
      {
          auto cMgr = ChannelMgr(channel->GetTeam());
          if (Channel* chn = cMgr.GetChannel(channel->GetChannelName(),
          nullptr, false))
          {
              if (chn->IsVoiceEnabled())
                  chn->ToggleVoice();
          }
      }
  }

  m_VoiceChatChannels.erase(channel->GetChannelId());
  delete channel;

  if (m_socket)
  {
      VoiceChatServerPacket data(VOICECHAT_CMSG_DELETE_CHANNEL, 5);
      data << type;
      data << id;
      m_socket->SendPacket(data);
  }
}

// check if channel request has already been created
bool VoiceChatMgr::IsVoiceChatChannelBeingCreated(VoiceChatChannelTypes type,
uint32 groupId, const std::string& name, TeamId team)
{
    for (const auto& req : m_requests)
    {
        if (req.type != type)
            continue;
        if (groupId && req.groupid != groupId)
            continue;
        if (!name.empty() && req.channel_name != name)
            continue;
        if (req.team != team)
            continue;

        return true;
    }
    return false;
}

void VoiceChatMgr::CreateGroupVoiceChatChannel(uint32 groupId)
{
    if (GetGroupVoiceChatChannel(groupId))
        return;

    CreateVoiceChatChannel(VOICECHAT_CHANNEL_GROUP, groupId);
}

void VoiceChatMgr::CreateRaidVoiceChatChannel(uint32 groupId)
{
    if (GetRaidVoiceChatChannel(groupId))
        return;

    CreateVoiceChatChannel(VOICECHAT_CHANNEL_RAID, groupId);
}

void VoiceChatMgr::CreateBattlegroundVoiceChatChannel(uint32 instanceId, TeamId
team)
{
    if (GetBattlegroundVoiceChatChannel(instanceId, team))
        return;

    CreateVoiceChatChannel(VOICECHAT_CHANNEL_BG, instanceId, "", team);
}

void VoiceChatMgr::CreateCustomVoiceChatChannel(const std::string& name, TeamId team)
{
    if (GetCustomVoiceChatChannel(name, team))
        return;

    CreateVoiceChatChannel(VOICECHAT_CHANNEL_CUSTOM, 0, name, team);
}
//
void VoiceChatMgr::DeleteGroupVoiceChatChannel(uint32 groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* channel = GetGroupVoiceChatChannel(groupId))
    {
        DeleteVoiceChatChannel(channel);
    }
}

void VoiceChatMgr::DeleteRaidVoiceChatChannel(uint32 groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* channel = GetRaidVoiceChatChannel(groupId))
    {
        DeleteVoiceChatChannel(channel);
    }
}

void VoiceChatMgr::DeleteBattlegroundVoiceChatChannel(uint32 instanceId, TeamId
team)
{
    if (!instanceId)
        return;

    if (VoiceChatChannel* channel =
    GetBattlegroundVoiceChatChannel(instanceId, team))
    {
        DeleteVoiceChatChannel(channel);
    }
}

void VoiceChatMgr::DeleteCustomVoiceChatChannel(const std::string& name, TeamId
team)
{
    if (name.empty())
        return;

    if (VoiceChatChannel* v_channel = GetCustomVoiceChatChannel(name, team))
    {
        DeleteVoiceChatChannel(v_channel);
    }
}

void VoiceChatMgr::ConvertToRaidChannel(uint32 groupId)
{
    if (VoiceChatChannel* chn = GetGroupVoiceChatChannel(groupId))
        chn->ConvertToRaid();
}

VoiceChatChannel* VoiceChatMgr::GetVoiceChatChannel(uint16 channel_id)
{
    auto itr = m_VoiceChatChannels.find(channel_id);
    if (itr == m_VoiceChatChannels.end())
        return nullptr;

    return itr->second;
}
//
VoiceChatChannel* VoiceChatMgr::GetGroupVoiceChatChannel(uint32 group_id)
{
    for (auto& channel : m_VoiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() == VOICECHAT_CHANNEL_GROUP && chn->GetGroupId() ==
        group_id)
            return chn;
    }

    return nullptr;
}
//
VoiceChatChannel* VoiceChatMgr::GetRaidVoiceChatChannel(uint32 group_id)
{
    for (auto& channel : m_VoiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() == VOICECHAT_CHANNEL_RAID && chn->GetGroupId() ==
        group_id)
            return chn;
    }

    return nullptr;
}

VoiceChatChannel* VoiceChatMgr::GetBattlegroundVoiceChatChannel(uint32
instanceId, TeamId team)
{
    for (auto& channel : m_VoiceChatChannels)
    {
        // for BG use bg's instanceID as groupID
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() == VOICECHAT_CHANNEL_BG && chn->GetGroupId() ==
        instanceId && chn->GetTeam() == team)
            return chn;
    }

    return nullptr;
}

VoiceChatChannel* VoiceChatMgr::GetCustomVoiceChatChannel(const std::string& name, TeamId team)
{
    for (auto& channels : m_VoiceChatChannels)
    {
        VoiceChatChannel* v_chan = channels.second;
        if (v_chan->GetType() == VOICECHAT_CHANNEL_CUSTOM &&
        v_chan->GetChannelName() == name && v_chan->GetTeam() ==
        GetCustomChannelTeam(team))
            return v_chan;
    }

    return nullptr;
}
//
// get possible voice channels after login or voice chat enable
std::vector<VoiceChatChannel*> VoiceChatMgr::GetPossibleVoiceChatChannels(ObjectGuid guid)
{
    std::vector<VoiceChatChannel*> channel_list;
    Player* plr = ObjectAccessor::FindConnectedPlayer(guid);
    if (!plr)
        return channel_list;

    for (auto& channel : m_VoiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        if (chn->GetType() != VOICECHAT_CHANNEL_CUSTOM)
            continue;

        if (chn->GetTeam() != GetCustomChannelTeam(plr->GetTeamId()))
            continue;

          {
            auto cMgr = ChannelMgr(plr->GetTeamId());
            Channel* chan = cMgr.GetChannel(chn->GetChannelName(), nullptr,
            false); if (chan && chan->IsOn(guid) && !chan->IsBanned(guid) &&
            chan->IsVoiceEnabled())
            {
                channel_list.push_back(chn);
            }
        }
    }

    return channel_list;
}

// create group/raid/bg channels after (re)connect to voice server
void VoiceChatMgr::RestoreVoiceChatChannels() {
  // Replace Messager with EventEmitter
    sVoiceChatMgr.GetEventEmitter() += [](VoiceChatMgr* world)
        {
            ChatHandler(nullptr).DoForAllValidSessions([](Player* player)
                {
                    const WorldSession* sess = player->GetSession();
                    if (sess->IsVoiceChatEnabled())
                    {
                        if (player)
                        {
                            if (Group* grp = player->GetGroup())
                            {
                                if (!grp->isBGGroup())
                                {
                                    if (grp->isRaidGroup())
                                        sVoiceChatMgr.AddToRaidVoiceChatChannel(player->GetGUID(),
                                            grp->GetId());
                                    else
                                        sVoiceChatMgr.AddToGroupVoiceChatChannel(player->GetGUID(),
                                            grp->GetId());
                                }
                                else
                                {
                                    sVoiceChatMgr.AddToBattlegroundVoiceChatChannel(player->GetGUID());
                                }
                            }
                            if (Group* grp = player->GetOriginalGroup())
                            {
                                if (!grp->isBGGroup())
                                {
                                    if (grp->isRaidGroup())
                                        sVoiceChatMgr.AddToRaidVoiceChatChannel(player->GetGUID(),
                                            grp->GetId());
                                    else
                                        sVoiceChatMgr.AddToGroupVoiceChatChannel(player->GetGUID(),
                                            grp->GetId());
                                }
                                else
                                {
                                    sVoiceChatMgr.AddToBattlegroundVoiceChatChannel(player->GetGUID());
                                }
                            }
                        }
                    }
                });
        };
}

void VoiceChatMgr::DeleteAllChannels() {
  for (auto &channel : m_VoiceChatChannels) {
    DeleteVoiceChatChannel(channel.second);
  }
  m_VoiceChatChannels.clear();
}
// if cross faction channels are enabled, team is always ALLIANCE
TeamId VoiceChatMgr::GetCustomChannelTeam(TeamId team)
{
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL))
        return TEAM_ALLIANCE;
    else
        return team;
}
void VoiceChatMgr::AddToGroupVoiceChatChannel(ObjectGuid guid, uint32
groupId)
{
    if (!groupId)
        return;

    VoiceChatChannel* v_channel = GetGroupVoiceChatChannel(groupId);
    if (!v_channel)
    {
        CreateGroupVoiceChatChannel(groupId);
        return;
    }

    v_channel->AddVoiceChatMember(guid);
}
//
void VoiceChatMgr::AddToRaidVoiceChatChannel(ObjectGuid guid, uint32 groupId)
{
    if (!groupId)
        return;

    VoiceChatChannel* v_channel = GetRaidVoiceChatChannel(groupId);
    if (!v_channel)
    {
        CreateRaidVoiceChatChannel(groupId);
        return;
    }

    v_channel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToBattlegroundVoiceChatChannel(ObjectGuid guid)
{
    Player* plr = ObjectAccessor::FindPlayer(guid);
    if (!plr)
        return;

    if (!plr->InBattleground())
        return;

    // for BG use bg's instanceID as groupID
    VoiceChatChannel* v_channel =
    GetBattlegroundVoiceChatChannel(plr->GetBattlegroundId(),
    plr->GetBgTeamId()); if (!v_channel)
    {
        CreateBattlegroundVoiceChatChannel(plr->GetBattlegroundId(),
        plr->GetBgTeamId()); return;
    }

    v_channel->AddVoiceChatMember(guid);
}

void VoiceChatMgr::AddToCustomVoiceChatChannel(ObjectGuid guid, const std::string& name, TeamId team)
{
    if (name.empty())
        return;

    VoiceChatChannel* v_channel = GetCustomVoiceChatChannel(name, team);
    if (!v_channel)
    {
        CreateCustomVoiceChatChannel(name, team);
        return;
    }

    v_channel->AddVoiceChatMember(guid);
}
//
void VoiceChatMgr::RemoveFromGroupVoiceChatChannel(ObjectGuid guid, uint32
groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* v_channel = GetGroupVoiceChatChannel(groupId))
    {
        v_channel->RemoveVoiceChatMember(guid);
    }
}

void VoiceChatMgr::RemoveFromRaidVoiceChatChannel(ObjectGuid guid, uint32
groupId)
{
    if (!groupId)
        return;

    if (VoiceChatChannel* v_channel = GetRaidVoiceChatChannel(groupId))
    {
        v_channel->RemoveVoiceChatMember(guid);
    }
}

void VoiceChatMgr::RemoveFromBattlegroundVoiceChatChannel(ObjectGuid guid)
{
    Player* plr = ObjectAccessor::FindPlayer(guid);
    if (!plr)
        return;

    if (!plr->InBattleground())
        return;

    if (VoiceChatChannel* v_channel =
    GetBattlegroundVoiceChatChannel(plr->GetBattlegroundId(),
    plr->GetBgTeamId()))
    {
        v_channel->RemoveVoiceChatMember(guid);
    }
}


void VoiceChatMgr::RemoveFromCustomVoiceChatChannel(ObjectGuid guid, const std::string& name, TeamId team)
{
    if (name.empty())
        return;

    if (VoiceChatChannel* v_channel = GetCustomVoiceChatChannel(name, team))
    {
        v_channel->RemoveVoiceChatMember(guid);
    }
}
//
void VoiceChatMgr::EnableChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!m_socket)
    {
        LOG_ERROR("sql.sql", "fug");
        return;
    }

    LOG_ERROR("sql.sql", "VoiceChatMgr: Channel {} activate slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_ADD_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    m_socket->SendPacket(data);
}
//
void VoiceChatMgr::DisableChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if(!m_socket)
        return;

    LOG_ERROR("sql.sql", "VoiceChatMgr: Channel {} deactivate slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_REMOVE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    m_socket->SendPacket(data);
}
//
void VoiceChatMgr::VoiceChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!m_socket)
        return;

    LOG_ERROR("sql.sql", "VoiceChatMgr: Channel {} voice slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_VOICE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    m_socket->SendPacket(data);
}
//
void VoiceChatMgr::DevoiceChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!m_socket)
        return;

      LOG_ERROR("sql.sql", "VoiceChatMgr: Channel {} devoice slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_DEVOICE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    m_socket->SendPacket(data);
}

void VoiceChatMgr::MuteChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!m_socket)
        return;

    LOG_ERROR("sql.sql", "VoiceChatMgr: Channel {} mute slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_MUTE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    m_socket->SendPacket(data);
}

void VoiceChatMgr::UnmuteChannelSlot(uint16 channel_id, uint8 slot_id)
{
    if (!m_socket)
        return;

    LOG_ERROR("sql.sql", "VoiceChatMgr: Channel {} unmute slot {}", (int)channel_id, (int)slot_id);

    VoiceChatServerPacket data(VOICECHAT_CMSG_UNMUTE_MEMBER, 5);
    data << channel_id;
    data << slot_id;
    m_socket->SendPacket(data);
}

void VoiceChatMgr::JoinAvailableVoiceChatChannels(WorldSession* session)
{
    if (!CanUseVoiceChat())
        return;

    // send available voice channels
    if (Player* player = session->GetPlayer())
    {
        if (Group* grp = player->GetGroup())
        {
            if (!grp->isBGGroup())
            {
                if (grp->isRaidGroup())
                    AddToRaidVoiceChatChannel(player->GetGUID(),
                    grp->GetId());
                else
                    AddToGroupVoiceChatChannel(player->GetGUID(),
                    grp->GetId());
            }
            else
            {
                AddToBattlegroundVoiceChatChannel(player->GetGUID());
            }
        }
        if (Group* grp = player->GetOriginalGroup())
        {
            if (grp->isRaidGroup())
                AddToRaidVoiceChatChannel(player->GetGUID(),
                grp->GetId());
            else
                AddToGroupVoiceChatChannel(player->GetGUID(),
                grp->GetId());
        }

        std::vector<VoiceChatChannel*> channel_list =
        GetPossibleVoiceChatChannels(player->GetGUID());
        for (const auto& channel : channel_list)
        {
            channel->AddVoiceChatMember(player->GetGUID());
        }
    }
}

// Not used currently
void VoiceChatMgr::SendAvailableVoiceChatChannels(WorldSession* session)
{
    if (!CanUseVoiceChat())
        return;

    // send available voice channels
    if (Player* player = session->GetPlayer())
    {
        if (Group* grp = player->GetGroup())
        {
            if (!grp->isBGGroup())
            {
                if (grp->isRaidGroup())
                {
                    if (VoiceChatChannel* chn =
                    GetRaidVoiceChatChannel(grp->GetId()))
                    {
                        chn->SendAvailableVoiceChatChannel(session);
                    }
                }
                else
                {
                    if (VoiceChatChannel* chn =
                    GetGroupVoiceChatChannel(grp->GetId()))
                    {
                        chn->SendAvailableVoiceChatChannel(session);
                    }
                }
            }
            else
            {
                if (VoiceChatChannel* chn =
                GetBattlegroundVoiceChatChannel(player->GetBattlegroundId(),
                player->GetBgTeamId()))
                {
                    chn->SendAvailableVoiceChatChannel(session);
                }
            }
        }
        if (Group* grp = player->GetOriginalGroup())
        {
            if (grp->isRaidGroup())
            {
                if (VoiceChatChannel* chn =
                GetRaidVoiceChatChannel(grp->GetId()))
                {
                    chn->SendAvailableVoiceChatChannel(session);
                }
            }
            else
            {
                if (VoiceChatChannel* chn =
                GetGroupVoiceChatChannel(grp->GetId()))
                {
                    chn->SendAvailableVoiceChatChannel(session);
                }
            }
        }

        std::vector<VoiceChatChannel*> channel_list =
        GetPossibleVoiceChatChannels(player->GetGUID()); for (auto
        channel : channel_list)
        {
            channel->SendAvailableVoiceChatChannel(session);
        }
    }
}

void VoiceChatMgr::RemoveFromVoiceChatChannels(ObjectGuid guid)
{
    for (const auto& channel : m_VoiceChatChannels)
    {
        VoiceChatChannel* chn = channel.second;
        chn->RemoveVoiceChatMember(guid);
    }
}
//
void VoiceChatMgr::SendVoiceChatStatus(bool status) {
  WorldPacket data(SMSG_VOICE_CHAT_STATUS, 1);
  data << uint8(status);
  sWorldSessionMgr->SendGlobalMessage(&data);
}
//
void VoiceChatMgr::SendVoiceChatServiceMessage(Opcodes opcode) {
  WorldPacket data(opcode);
  sWorldSessionMgr->SendGlobalMessage(&data);
}

// command handlers
void VoiceChatMgr::DisableVoiceChat()
{
    if (!m_voiceService.stopped() || (m_socket && m_socket->IsOpen()))
    {
        SocketDisconnected();
    }

    enabled = false;
    state = VOICECHAT_DISCONNECTED;
    SendVoiceChatStatus(false);
}

void VoiceChatMgr::EnableVoiceChat()
{
    if (enabled)
        return;

    enabled = true;
    // Init(m_ioContext);
    SendVoiceChatStatus(true);
}

VoiceChatStatistics VoiceChatMgr::GetStatistics()
{
    VoiceChatStatistics stats;

    // amount of channels
    stats.channels = 0;
    for (const auto& chn : m_VoiceChatChannels)
    {
        stats.channels++;
    }

    // amount of active users
    stats.active_users = 0;
    stats.totalVoiceChatEnabled = 0;
    stats.totalVoiceMicEnabled = 0;
    ChatHandler(nullptr).DoForAllValidSessions([&](Player* player)
    {
        if (player->GetSession()->IsVoiceChatEnabled())
            stats.totalVoiceChatEnabled++;
        if (player->GetSession()->IsMicEnabled())
            stats.totalVoiceMicEnabled++;
        if (player->GetSession()->GetCurrentVoiceChannelId())
            stats.active_users++;
    });

    return stats;
}

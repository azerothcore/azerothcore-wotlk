/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/** \file
    \ingroup u2w
*/

#include "WorldSocket.h"                                    // must be first to make ACE happy with ACE includes in it
#include "Common.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Opcodes.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Pet.h"
#include "Player.h"
#include "Vehicle.h"
#include "ObjectMgr.h"
#include "GuildMgr.h"
#include "Group.h"
#include "Guild.h"
#include "World.h"
#include "ObjectAccessor.h"
#include "BattlegroundMgr.h"
#include "OutdoorPvPMgr.h"
#include "MapManager.h"
#include "SocialMgr.h"
#include "zlib.h"
#include "ScriptMgr.h"
#include "Transport.h"
#include "WardenWin.h"
#include "WardenMac.h"
#include "SavingSystem.h"
#include "AccountMgr.h"
#ifdef ELUNA
#include "LuaEngine.h"
#endif

namespace {

std::string const DefaultPlayerName = "<none>";

} // namespace

bool MapSessionFilter::Process(WorldPacket* packet)
{
    if (packet->GetOpcode() >= NUM_MSG_TYPES)
        return true;

    OpcodeHandler const& opHandle = opcodeTable[packet->GetOpcode()];

    if (opHandle.packetProcessing == PROCESS_INPLACE)
        return true;

    if (opHandle.packetProcessing == PROCESS_THREADUNSAFE)
        return false;

    Player* player = m_pSession->GetPlayer();
    if (!player)
        return false;

    return player->IsInWorld();
}

bool WorldSessionFilter::Process(WorldPacket* packet)
{
    if (packet->GetOpcode() >= NUM_MSG_TYPES)
        return true;

    OpcodeHandler const& opHandle = opcodeTable[packet->GetOpcode()];

    if (opHandle.packetProcessing == PROCESS_INPLACE)
        return true;

    if (opHandle.packetProcessing == PROCESS_THREADUNSAFE)
        return true;

    Player* player = m_pSession->GetPlayer();
    if (!player)
        return true;

    return (player->IsInWorld() == false);
}

/// WorldSession constructor
WorldSession::WorldSession(uint32 id, WorldSocket* sock, AccountTypes sec, uint8 expansion, time_t mute_time, LocaleConstant locale, uint32 recruiter, bool isARecruiter, bool skipQueue, uint32 TotalTime):
    m_muteTime(mute_time),
    m_timeOutTime(0),
    _lastAuctionListItemsMSTime(0),
    _lastAuctionListOwnerItemsMSTime(0),
    m_GUIDLow(0),
    _player(NULL),
    m_Socket(sock),
    _security(sec),
    _skipQueue(skipQueue),
    _accountId(id),    
    m_expansion(expansion),
    m_total_time(TotalTime),
    _logoutTime(0),
    m_inQueue(false),
    m_playerLoading(false),
    m_playerLogout(false),
    m_playerSave(false),
    m_sessionDbcLocale(sWorld->GetDefaultDbcLocale()),
    m_sessionDbLocaleIndex(locale),
    m_latency(0),
    m_clientTimeDelay(0),
    m_TutorialsChanged(false),
    recruiterId(recruiter),    
    isRecruiter(isARecruiter),
    m_currentBankerGUID(0),
    timeWhoCommandAllowed(0)
{
    memset(m_Tutorials, 0, sizeof(m_Tutorials));

    _warden = NULL;
    _offlineTime = 0;
    _kicked = false;
    _shouldSetOfflineInDB = true;

    if (sock)
    {
        m_Address = sock->GetRemoteAddress();
        sock->AddReference();
        ResetTimeOutTime();
        LoginDatabase.PExecute("UPDATE account SET online = online | (1<<(%u-1)) WHERE id = %u;", realmID, GetAccountId());
    }

    InitializeQueryCallbackParameters();
}

/// WorldSession destructor
WorldSession::~WorldSession()
{
    LoginDatabase.PExecute("UPDATE account SET totaltime = %u WHERE id = %u", GetTotalTime(), GetAccountId());

    ///- unload player if not unloaded
    if (_player)
        LogoutPlayer (true);

    /// - If have unclosed socket, close it
    if (m_Socket)
    {
        m_Socket->CloseSocket();
        m_Socket->RemoveReference();
        m_Socket = NULL;
    }

    if (_warden)
    {
        delete _warden;
        _warden = NULL;
    }

    ///- empty incoming packet queue
    WorldPacket* packet = NULL;
    while (_recvQueue.next(packet))
        delete packet;

    if (GetShouldSetOfflineInDB())
        LoginDatabase.PExecute("UPDATE account SET online = online & ~(1<<(%u-1)) WHERE id = %u;", realmID, GetAccountId());     // One-time query
}

std::string const & WorldSession::GetPlayerName() const
{
    return _player != NULL ? _player->GetName() : DefaultPlayerName;
}

std::string WorldSession::GetPlayerInfo() const
{
    std::ostringstream ss;

    ss << "[Player: " << GetPlayerName()
       << " (Guid: " << (_player != NULL ? _player->GetGUID() : 0)
       << ", Account: " << GetAccountId() << ")]";

    return ss.str();
}

/// Get player guid if available. Use for logging purposes only
uint32 WorldSession::GetGuidLow() const
{
    return GetPlayer() ? GetPlayer()->GetGUIDLow() : 0;
}

/// Send a packet to the client
void WorldSession::SendPacket(WorldPacket const* packet)
{
    if (!m_Socket)
        return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS) && defined(TRINITY_DEBUG)
    // Code for network use statistic
    static uint64 sendPacketCount = 0;
    static uint64 sendPacketBytes = 0;

    static time_t firstTime = time(NULL);
    static time_t lastTime = firstTime;                     // next 60 secs start time

    static uint64 sendLastPacketCount = 0;
    static uint64 sendLastPacketBytes = 0;

    time_t cur_time = time(NULL);

    if ((cur_time - lastTime) < 60)
    {
        sendPacketCount+=1;
        sendPacketBytes+=packet->size();

        sendLastPacketCount+=1;
        sendLastPacketBytes+=packet->size();
    }
    else
    {
        uint64 minTime = uint64(cur_time - lastTime);
        uint64 fullTime = uint64(lastTime - firstTime);

        sLog->outDetail("Send all time packets count: " UI64FMTD " bytes: " UI64FMTD " avr.count/sec: %f avr.bytes/sec: %f time: %u", sendPacketCount, sendPacketBytes, float(sendPacketCount)/fullTime, float(sendPacketBytes)/fullTime, uint32(fullTime));

        sLog->outDetail("Send last min packets count: " UI64FMTD " bytes: " UI64FMTD " avr.count/sec: %f avr.bytes/sec: %f", sendLastPacketCount, sendLastPacketBytes, float(sendLastPacketCount)/minTime, float(sendLastPacketBytes)/minTime);

        lastTime = cur_time;
        sendLastPacketCount = 1;
        sendLastPacketBytes = packet->wpos();               // wpos is real written size
    }
#endif                                                      // !TRINITY_DEBUG

    sScriptMgr->OnPacketSend(this, *packet);

#ifdef ELUNA
    if (!sEluna->OnPacketSend(this, *packet))
        return;
#endif

    if (m_Socket->SendPacket(*packet) == -1)
        m_Socket->CloseSocket();
}

/// Add an incoming packet to the queue
void WorldSession::QueuePacket(WorldPacket* new_packet)
{
    _recvQueue.add(new_packet);
}

/// Update the WorldSession (triggered by World update)
bool WorldSession::Update(uint32 diff, PacketFilter& updater)
{
    if (updater.ProcessLogout())
    {
        UpdateTimeOutTime(diff);
        if (IsConnectionIdle())
            m_Socket->CloseSocket();
    }

    HandleTeleportTimeout(updater.ProcessLogout());

    uint32 _startMSTime = getMSTime();
    WorldPacket* packet = NULL;
    WorldPacket* movementPacket = NULL;
    bool deletePacket = true;
    WorldPacket* firstDelayedPacket = NULL;
    uint32 processedPackets = 0;

    while (m_Socket && !m_Socket->IsClosed() && !_recvQueue.empty() && _recvQueue.peek(true) != firstDelayedPacket && _recvQueue.next(packet, updater))
    {
        if (packet->GetOpcode() < NUM_MSG_TYPES)
        {
            OpcodeHandler &opHandle = opcodeTable[packet->GetOpcode()];
            try
            {
                switch (opHandle.status)
                {
                    case STATUS_LOGGEDIN:
                        if (!_player)
                        {
                            // pussywizard: such packets were sent to do something for a character that has already logged out, skip them
                        }
                        else if (!_player->IsInWorld())
                        {
                            // pussywizard: such packets may do something important and the player is just being teleported, move to the end of the queue
                            // pussywizard: previously such were skipped, so leave it as it is xD proper code below if we wish to change that

                            // pussywizard: requeue only important packets not related to maps (PROCESS_THREADUNSAFE)
                            /*if (opHandle.packetProcessing == PROCESS_THREADUNSAFE)
                            {
                                if (!firstDelayedPacket)
                                    firstDelayedPacket = packet;
                                deletePacket = false;
                                QueuePacket(packet);
                            }*/
                        }
                        else
                        {
                            if (opHandle.isGrouppedMovementOpcode)
                            {
                                if (movementPacket)
                                    delete movementPacket;
                                movementPacket = new WorldPacket(packet->GetOpcode(), 0);
                                movementPacket->append(*((ByteBuffer*)packet));
                            }
                            else
                            {
                                if (movementPacket)
                                {
                                    HandleMovementOpcodes(*movementPacket);
                                    delete movementPacket;
                                    movementPacket = NULL;
                                }
                                sScriptMgr->OnPacketReceive(this, *packet);
#ifdef ELUNA
                                if (!sEluna->OnPacketReceive(this, *packet))
                                    break;
#endif
                                (this->*opHandle.handler)(*packet);
                            }
                        }
                        break;
                    case STATUS_TRANSFER:
                        if (_player && !_player->IsInWorld())
                        {
                            if (movementPacket)
                            {
                                delete movementPacket;
                                movementPacket = NULL;
                            }
                            sScriptMgr->OnPacketReceive(this, *packet);
#ifdef ELUNA
                            if (!sEluna->OnPacketReceive(this, *packet))
                                break;
#endif
                            (this->*opHandle.handler)(*packet);
                        }
                        break;
                    case STATUS_AUTHED:
                        if (m_inQueue) // prevent cheating
                            break;

                        sScriptMgr->OnPacketReceive(this, *packet);
#ifdef ELUNA
                        if (!sEluna->OnPacketReceive(this, *packet))
                            break;
#endif
                        (this->*opHandle.handler)(*packet);
                        break;
                    case STATUS_NEVER:
                        break;
                    case STATUS_UNHANDLED:
                        break;
                }
            }
            catch(ByteBufferException &)
            {
                sLog->outError("WorldSession::Update ByteBufferException occured while parsing a packet (opcode: %u) from client %s, accountid=%i. Skipped packet.", packet->GetOpcode(), GetRemoteAddress().c_str(), GetAccountId());
                if (sLog->IsOutDebug())
                {
                    sLog->outDebug(LOG_FILTER_NETWORKIO, "Dumping error causing packet:");
                    packet->hexlike();
                }
            }
        }

        if (deletePacket)
            delete packet;
        else
            deletePacket = true;

        if (++processedPackets >= 150) // limit (by count) packets processed in one update, prevent DDoS
            break;

        if (getMSTimeDiff(_startMSTime, getMSTime()) >= 3) // limit (by time) packets processed in one update, prevent DDoS
            break;
    }

    if (movementPacket)
    {
        if (_player && _player->IsInWorld())
            HandleMovementOpcodes(*movementPacket);
        delete movementPacket;
    }

    if (m_Socket && !m_Socket->IsClosed())
        ProcessQueryCallbacks();

    if (updater.ProcessLogout())
    {
        time_t currTime = time(NULL);
        if (ShouldLogOut(currTime) && !m_playerLoading)
            LogoutPlayer(true);

        if (m_Socket && !m_Socket->IsClosed() && _warden)
            _warden->Update();

        if (m_Socket && m_Socket->IsClosed())
        {
            m_Socket->RemoveReference();
            m_Socket = NULL;
        }

        if (!m_Socket)
            return false;
    }

    return true;
}

bool WorldSession::HandleSocketClosed()
{
    if (m_Socket && m_Socket->IsClosed() && !IsKicked() && GetPlayer() && !PlayerLogout() && GetPlayer()->m_taxi.empty() && GetPlayer()->IsInWorld() && !World::IsStopped())
    {
        m_Socket->RemoveReference();
        m_Socket = NULL;
        GetPlayer()->TradeCancel(false);
        return true;
    }
    return false;
}

void WorldSession::HandleTeleportTimeout(bool updateInSessions)
{
    // pussywizard: handle teleport ack timeout
    if (m_Socket && !m_Socket->IsClosed() && GetPlayer() && GetPlayer()->IsBeingTeleported())
    {
        time_t currTime = time(NULL);
        if (updateInSessions) // session update from World::UpdateSessions
        {
            if (GetPlayer()->IsBeingTeleportedFar() && GetPlayer()->GetSemaphoreTeleportFar()+sWorld->getIntConfig(CONFIG_TELEPORT_TIMEOUT_FAR) < currTime)
                while (GetPlayer() && GetPlayer()->IsBeingTeleportedFar())
                    HandleMoveWorldportAckOpcode();
        }
        else // session update from Map::Update
        {
            if (GetPlayer()->IsBeingTeleportedNear() && GetPlayer()->GetSemaphoreTeleportNear()+sWorld->getIntConfig(CONFIG_TELEPORT_TIMEOUT_NEAR) < currTime)
                while (GetPlayer() && GetPlayer()->IsInWorld() && GetPlayer()->IsBeingTeleportedNear())
                {
                    Player* plMover = GetPlayer()->m_mover->ToPlayer();
                    if (!plMover)
                        break;
                    WorldPacket pkt(MSG_MOVE_TELEPORT_ACK, 20);
                    pkt.append(plMover->GetPackGUID());
                    pkt << uint32(0); // flags
                    pkt << uint32(0); // time
                    HandleMoveTeleportAck(pkt);
                }
        }
    }
}

/// %Log the player out
void WorldSession::LogoutPlayer(bool save)
{
    // finish pending transfers before starting the logout
    while (_player && _player->IsBeingTeleportedFar())
        HandleMoveWorldportAckOpcode();

    m_playerLogout = true;
    m_playerSave = save;

    if (_player)
    {
        if (uint64 lguid = _player->GetLootGUID())
            DoLootRelease(lguid);

        ///- If the player just died before logging out, make him appear as a ghost
        //FIXME: logout must be delayed in case lost connection with client in time of combat
        if (_player->GetDeathTimer())
        {
            _player->getHostileRefManager().deleteReferences();
            _player->BuildPlayerRepop();
            _player->RepopAtGraveyard();
        }
        else if (_player->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
        {
            // this will kill character by SPELL_AURA_SPIRIT_OF_REDEMPTION
            _player->RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);
            _player->KillPlayer();
            _player->BuildPlayerRepop();
            _player->RepopAtGraveyard();
        }
        else if (_player->HasPendingBind())
        {
            _player->RepopAtGraveyard();
            _player->SetPendingBind(0, 0);
        }

        // pussywizard: leave whole bg on logout (character stays ingame when necessary)
        // pussywizard: GetBattleground() checked inside
        _player->LeaveBattleground();

        // pussywizard: checked first time
        if (!_player->IsBeingTeleportedFar() && !_player->m_InstanceValid && !_player->IsGameMaster())
            _player->RepopAtGraveyard();

        sOutdoorPvPMgr->HandlePlayerLeaveZone(_player, _player->GetZoneId());

        // pussywizard: remove from battleground queues on logout
        for (int i=0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
            if (BattlegroundQueueTypeId bgQueueTypeId = _player->GetBattlegroundQueueTypeId(i))
            {
                _player->RemoveBattlegroundQueueId(bgQueueTypeId);
                sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId).RemovePlayer(_player->GetGUID(), false, i);
                // track if player logs out after invited to join BG
                if(_player->IsInvitedForBattlegroundInstance() && sWorld->getBoolConfig(CONFIG_BATTLEGROUND_TRACK_DESERTERS))
                {
                    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_DESERTER_TRACK);
                    stmt->setUInt32(0, _player->GetGUIDLow());
                    stmt->setUInt8(1, BG_DESERTION_TYPE_INVITE_LOGOUT);
                    CharacterDatabase.Execute(stmt);
                }
            }

        ///- If the player is in a guild, update the guild roster and broadcast a logout message to other guild members
        if (Guild* guild = sGuildMgr->GetGuildById(_player->GetGuildId()))
            guild->HandleMemberLogout(this);

        ///- Remove pet
        _player->RemovePet(NULL, PET_SAVE_AS_CURRENT);

        // pussywizard: on logout remove auras that are removed at map change (before saving to db)
        // there are some positive auras from boss encounters that can be kept by logging out and logging in after boss is dead, and may be used on next bosses
        _player->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CHANGE_MAP);

        ///- If the player is in a group (or invited), remove him. If the group if then only 1 person, disband the group.
        _player->UninviteFromGroup();

        // remove player from the group if he is:
        // a) in group; b) not in raid group; c) logging out normally (not being kicked or disconnected)
        if (_player->GetGroup() && !_player->GetGroup()->isRaidGroup() && !_player->GetGroup()->isLFGGroup() && m_Socket)
            _player->RemoveFromGroup();

        // pussywizard: checked second time after being removed from a group
        if (!_player->IsBeingTeleportedFar() && !_player->m_InstanceValid && !_player->IsGameMaster())
            _player->RepopAtGraveyard();

        // Repop at GraveYard or other player far teleport will prevent saving player because of not present map
        // Teleport player immediately for correct player save
        while (_player && _player->IsBeingTeleportedFar())
            HandleMoveWorldportAckOpcode();

        ///- empty buyback items and save the player in the database
        // some save parts only correctly work in case player present in map/player_lists (pets, etc)
        SavingSystemMgr::InsertToSavingSkipListIfNeeded(_player->GetNextSave()); // pussywizard
        if (save)
        {
            uint32 eslot;
            for (int j = BUYBACK_SLOT_START; j < BUYBACK_SLOT_END; ++j)
            {
                eslot = j - BUYBACK_SLOT_START;
                _player->SetUInt64Value(PLAYER_FIELD_VENDORBUYBACK_SLOT_1 + (eslot * 2), 0);
                _player->SetUInt32Value(PLAYER_FIELD_BUYBACK_PRICE_1 + eslot, 0);
                _player->SetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + eslot, 0);
            }
            _player->SaveToDB(false, true);
        }

        ///- Leave all channels before player delete...
        _player->CleanupChannels();

        //! Send update to group and reset stored max enchanting level
        if (_player->GetGroup())
        {
            _player->GetGroup()->SendUpdate();
            _player->GetGroup()->ResetMaxEnchantingLevel();
        }

        //! Broadcast a logout message to the player's friends
        if (AccountMgr::IsGMAccount(GetSecurity())) // pussywizard: only for non-gms
            sSocialMgr->SendFriendStatus(_player, FRIEND_OFFLINE, _player->GetGUIDLow(), true);
        sSocialMgr->RemovePlayerSocial(_player->GetGUIDLow());

        //! Call script hook before deletion
        sScriptMgr->OnPlayerLogout(_player);

        sLog->outChar("Account: %d (IP: %s) Logout Character:[%s] (GUID: %u) Level: %d", GetAccountId(), GetRemoteAddress().c_str(), _player->GetName().c_str(), _player->GetGUIDLow(), _player->getLevel());

        //! Remove the player from the world
        // the player may not be in the world when logging out
        // e.g if he got disconnected during a transfer to another map
        // calls to GetMap in this case may cause crashes
        _player->CleanupsBeforeDelete();
        if (Map* _map = _player->FindMap())
        {
            _map->RemovePlayerFromMap(_player, true);
            _map->AfterPlayerUnlinkFromMap();
        }

        SetPlayer(NULL); // pointer already deleted

        //! Send the 'logout complete' packet to the client
        //! Client will respond by sending 3x CMSG_CANCEL_TRADE, which we currently dont handle
        WorldPacket data(SMSG_LOGOUT_COMPLETE, 0);
        SendPacket(&data);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "SESSION: Sent SMSG_LOGOUT_COMPLETE Message");
#endif

        //! Since each account can only have one online character at any given time, ensure all characters for active account are marked as offline
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ACCOUNT_ONLINE);
        stmt->setUInt32(0, GetAccountId());
        CharacterDatabase.Execute(stmt);
    }

    m_playerLogout = false;
    m_playerSave = false;
    LogoutRequest(0);
}

/// Kick a player out of the World
void WorldSession::KickPlayer(bool setKicked)
{
    if (m_Socket)
        m_Socket->CloseSocket();

    if (setKicked)
        SetKicked(true); // pussywizard: the session won't be left ingame for 60 seconds and to also kick offline session
}

void WorldSession::SendNotification(const char *format, ...)
{
    if (format)
    {
        va_list ap;
        char szStr[1024];
        szStr[0] = '\0';
        va_start(ap, format);
        vsnprintf(szStr, 1024, format, ap);
        va_end(ap);

        WorldPacket data(SMSG_NOTIFICATION, (strlen(szStr) + 1));
        data << szStr;
        SendPacket(&data);
    }
}

void WorldSession::SendNotification(uint32 string_id, ...)
{
    char const* format = GetTrinityString(string_id);
    if (format)
    {
        va_list ap;
        char szStr[1024];
        szStr[0] = '\0';
        va_start(ap, string_id);
        vsnprintf(szStr, 1024, format, ap);
        va_end(ap);

        WorldPacket data(SMSG_NOTIFICATION, (strlen(szStr) + 1));
        data << szStr;
        SendPacket(&data);
    }
}

const char *WorldSession::GetTrinityString(int32 entry) const
{
    return sObjectMgr->GetTrinityString(entry, GetSessionDbLocaleIndex());
}

void WorldSession::Handle_NULL(WorldPacket& recvPacket)
{
    sLog->outError("SESSION: received unhandled opcode %s (0x%.4X)", LookupOpcodeName(recvPacket.GetOpcode()), recvPacket.GetOpcode());
}

void WorldSession::Handle_EarlyProccess(WorldPacket& recvPacket)
{
    sLog->outError("SESSION: received opcode %s (0x%.4X) that must be processed in WorldSocket::OnRead", LookupOpcodeName(recvPacket.GetOpcode()), recvPacket.GetOpcode());
}

void WorldSession::Handle_ServerSide(WorldPacket& recvPacket)
{
    sLog->outError("SESSION: received server-side opcode %s (0x%.4X)", LookupOpcodeName(recvPacket.GetOpcode()), recvPacket.GetOpcode());
}

void WorldSession::Handle_Deprecated(WorldPacket& recvPacket)
{
    sLog->outError("SESSION: received deprecated opcode %s (0x%.4X)", LookupOpcodeName(recvPacket.GetOpcode()), recvPacket.GetOpcode());
}

void WorldSession::SendAuthWaitQue(uint32 position)
{
    if (position == 0)
    {
        WorldPacket packet(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_OK);
        SendPacket(&packet);
    }
    else
    {
        WorldPacket packet(SMSG_AUTH_RESPONSE, 6);
        packet << uint8(AUTH_WAIT_QUEUE);
        packet << uint32(position);
        packet << uint8(0);                                 // unk
        SendPacket(&packet);
    }
}

void WorldSession::LoadGlobalAccountData()
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ACCOUNT_DATA);
    stmt->setUInt32(0, GetAccountId());
    LoadAccountData(CharacterDatabase.Query(stmt), GLOBAL_CACHE_MASK);
}

void WorldSession::LoadAccountData(PreparedQueryResult result, uint32 mask)
{
    for (uint32 i = 0; i < NUM_ACCOUNT_DATA_TYPES; ++i)
        if (mask & (1 << i))
            m_accountData[i] = AccountData();

    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();
        uint32 type = fields[0].GetUInt8();
        if (type >= NUM_ACCOUNT_DATA_TYPES)
        {
            sLog->outError("Table `%s` have invalid account data type (%u), ignore.", mask == GLOBAL_CACHE_MASK ? "account_data" : "character_account_data", type);
            continue;
        }

        if ((mask & (1 << type)) == 0)
        {
            sLog->outError("Table `%s` have non appropriate for table  account data type (%u), ignore.", mask == GLOBAL_CACHE_MASK ? "account_data" : "character_account_data", type);
            continue;
        }

        m_accountData[type].Time = time_t(fields[1].GetUInt32());
        m_accountData[type].Data = fields[2].GetString();
    }
    while (result->NextRow());
}

void WorldSession::SetAccountData(AccountDataType type, time_t tm, std::string const& data)
{
    uint32 id = 0;
    uint32 index = 0;
    if ((1 << type) & GLOBAL_CACHE_MASK)
    {
        id = GetAccountId();
        index = CHAR_REP_ACCOUNT_DATA;
    }
    else
    {
        // _player can be NULL and packet received after logout but m_GUID still store correct guid
        if (!m_GUIDLow)
            return;

        id = m_GUIDLow;
        index = CHAR_REP_PLAYER_ACCOUNT_DATA;
    }

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(index);
    stmt->setUInt32(0, id);
    stmt->setUInt8 (1, type);
    stmt->setUInt32(2, uint32(tm));
    stmt->setString(3, data);
    CharacterDatabase.Execute(stmt);

    m_accountData[type].Time = tm;
    m_accountData[type].Data = data;
}

void WorldSession::SendAccountDataTimes(uint32 mask)
{
    WorldPacket data(SMSG_ACCOUNT_DATA_TIMES, 4 + 1 + 4 + 8 * 4); // changed in WotLK
    data << uint32(time(NULL));                             // unix time of something
    data << uint8(1);
    data << uint32(mask);                                   // type mask
    for (uint32 i = 0; i < NUM_ACCOUNT_DATA_TYPES; ++i)
        if (mask & (1 << i))
            data << uint32(GetAccountData(AccountDataType(i))->Time);// also unix time
    SendPacket(&data);
}

void WorldSession::LoadTutorialsData()
{
    memset(m_Tutorials, 0, sizeof(uint32) * MAX_ACCOUNT_TUTORIAL_VALUES);

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_TUTORIALS);
    stmt->setUInt32(0, GetAccountId());
    if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
        for (uint8 i = 0; i < MAX_ACCOUNT_TUTORIAL_VALUES; ++i)
            m_Tutorials[i] = (*result)[i].GetUInt32();

    m_TutorialsChanged = false;
}

void WorldSession::SendTutorialsData()
{
    WorldPacket data(SMSG_TUTORIAL_FLAGS, 4 * MAX_ACCOUNT_TUTORIAL_VALUES);
    for (uint8 i = 0; i < MAX_ACCOUNT_TUTORIAL_VALUES; ++i)
        data << m_Tutorials[i];
    SendPacket(&data);
}

void WorldSession::SaveTutorialsData(SQLTransaction &trans)
{
    if (!m_TutorialsChanged)
        return;

    bool hasTutorials = false;
    for (uint8 i = 0; i < MAX_ACCOUNT_TUTORIAL_VALUES; ++i)
        if (m_Tutorials[i] != 0)
        {
            hasTutorials = true;
            break;
        }

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(hasTutorials ? CHAR_UPD_TUTORIALS : CHAR_INS_TUTORIALS);
    for (uint8 i = 0; i < MAX_ACCOUNT_TUTORIAL_VALUES; ++i)
        stmt->setUInt32(i, m_Tutorials[i]);
    stmt->setUInt32(MAX_ACCOUNT_TUTORIAL_VALUES, GetAccountId());
    trans->Append(stmt);

    m_TutorialsChanged = false;
}

void WorldSession::ReadMovementInfo(WorldPacket &data, MovementInfo* mi)
{
    data >> mi->flags;
    data >> mi->flags2;
    data >> mi->time;
    data >> mi->pos.PositionXYZOStream();

    if (mi->HasMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
    {
        data.readPackGUID(mi->transport.guid);

        data >> mi->transport.pos.PositionXYZOStream();
        data >> mi->transport.time;
        data >> mi->transport.seat;

        if (mi->HasExtraMovementFlag(MOVEMENTFLAG2_INTERPOLATED_MOVEMENT))
            data >> mi->transport.time2;
    }

    if (mi->HasMovementFlag(MovementFlags(MOVEMENTFLAG_SWIMMING | MOVEMENTFLAG_FLYING)) || (mi->HasExtraMovementFlag(MOVEMENTFLAG2_ALWAYS_ALLOW_PITCHING)))
        data >> mi->pitch;

    data >> mi->fallTime;

    if (mi->HasMovementFlag(MOVEMENTFLAG_FALLING))
    {
        data >> mi->jump.zspeed;
        data >> mi->jump.sinAngle;
        data >> mi->jump.cosAngle;
        data >> mi->jump.xyspeed;
    }

    if (mi->HasMovementFlag(MOVEMENTFLAG_SPLINE_ELEVATION))
        data >> mi->splineElevation;

    //! Anti-cheat checks. Please keep them in seperate if() blocks to maintain a clear overview.
    //! Might be subject to latency, so just remove improper flags.
    #ifdef TRINITY_DEBUG
    #define REMOVE_VIOLATING_FLAGS(check, maskToRemove) \
    { \
        if (check) \
        { \
            sLog->outDebug(LOG_FILTER_UNITS, "WorldSession::ReadMovementInfo: Violation of MovementFlags found (%s). " \
                "MovementFlags: %u, MovementFlags2: %u for player GUID: %u. Mask %u will be removed.", \
                STRINGIZE(check), mi->GetMovementFlags(), mi->GetExtraMovementFlags(), GetPlayer()->GetGUIDLow(), maskToRemove); \
            mi->RemoveMovementFlag((maskToRemove)); \
        } \
    }
    #else
    #define REMOVE_VIOLATING_FLAGS(check, maskToRemove) \
        if (check) \
            mi->RemoveMovementFlag((maskToRemove));
    #endif


    /*! This must be a packet spoofing attempt. MOVEMENTFLAG_ROOT sent from the client is not valid
        in conjunction with any of the moving movement flags such as MOVEMENTFLAG_FORWARD.
        It will freeze clients that receive this player's movement info.
    */
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_ROOT),
        MOVEMENTFLAG_ROOT);

    //! Cannot hover without SPELL_AURA_HOVER
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_HOVER) && !GetPlayer()->m_mover->HasAuraType(SPELL_AURA_HOVER), // pussywizard: added m_mover
        MOVEMENTFLAG_HOVER);

    //! Cannot ascend and descend at the same time
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_ASCENDING) && mi->HasMovementFlag(MOVEMENTFLAG_DESCENDING),
        MOVEMENTFLAG_ASCENDING | MOVEMENTFLAG_DESCENDING);

    //! Cannot move left and right at the same time
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_LEFT) && mi->HasMovementFlag(MOVEMENTFLAG_RIGHT),
        MOVEMENTFLAG_LEFT | MOVEMENTFLAG_RIGHT);

    //! Cannot strafe left and right at the same time
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_STRAFE_LEFT) && mi->HasMovementFlag(MOVEMENTFLAG_STRAFE_RIGHT),
        MOVEMENTFLAG_STRAFE_LEFT | MOVEMENTFLAG_STRAFE_RIGHT);

    //! Cannot pitch up and down at the same time
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_PITCH_UP) && mi->HasMovementFlag(MOVEMENTFLAG_PITCH_DOWN),
        MOVEMENTFLAG_PITCH_UP | MOVEMENTFLAG_PITCH_DOWN);

    //! Cannot move forwards and backwards at the same time
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_FORWARD) && mi->HasMovementFlag(MOVEMENTFLAG_BACKWARD),
        MOVEMENTFLAG_FORWARD | MOVEMENTFLAG_BACKWARD);

    //! Cannot walk on water without SPELL_AURA_WATER_WALK
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_WATERWALKING) && !GetPlayer()->m_mover->HasAuraType(SPELL_AURA_WATER_WALK), // pussywizard: added m_mover
        MOVEMENTFLAG_WATERWALKING);

    //! Cannot feather fall without SPELL_AURA_FEATHER_FALL
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_FALLING_SLOW) && !GetPlayer()->m_mover->HasAuraType(SPELL_AURA_FEATHER_FALL), // pussywizard: added m_mover
        MOVEMENTFLAG_FALLING_SLOW);

    /*! Cannot fly if no fly auras present. Exception is being a GM.
        Note that we check for account level instead of Player::IsGameMaster() because in some
        situations it may be feasable to use .gm fly on as a GM without having .gm on,
        e.g. aerial combat.
    */

    // pussywizard: remade this condition
    bool canFly = GetPlayer()->m_mover->HasAuraType(SPELL_AURA_FLY) || GetPlayer()->m_mover->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) ||
                  (GetPlayer()->m_mover->GetTypeId() == TYPEID_UNIT && GetPlayer()->m_mover->ToCreature()->CanFly()) || GetSecurity() > SEC_PLAYER;
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_FLYING | MOVEMENTFLAG_CAN_FLY) && !canFly,
        MOVEMENTFLAG_FLYING | MOVEMENTFLAG_CAN_FLY);

    // pussywizard: added condition for disable gravity
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY) && (GetPlayer()->m_mover->GetTypeId() == TYPEID_PLAYER || !canFly),
        MOVEMENTFLAG_DISABLE_GRAVITY);

    //! Cannot fly and fall at the same time
    REMOVE_VIOLATING_FLAGS(mi->HasMovementFlag(MOVEMENTFLAG_CAN_FLY | MOVEMENTFLAG_DISABLE_GRAVITY) && mi->HasMovementFlag(MOVEMENTFLAG_FALLING),
        MOVEMENTFLAG_FALLING);

    // Xinef: Spline enabled flag should be never sent by client, its internal movementflag
    REMOVE_VIOLATING_FLAGS(!GetPlayer()->m_mover->m_movementInfo.HasMovementFlag(MOVEMENTFLAG_SPLINE_ENABLED),
        MOVEMENTFLAG_SPLINE_ENABLED);

    #undef REMOVE_VIOLATING_FLAGS
}

void WorldSession::WriteMovementInfo(WorldPacket* data, MovementInfo* mi)
{
    data->appendPackGUID(mi->guid);

    *data << mi->flags;
    *data << mi->flags2;
    *data << mi->time;
    *data << mi->pos.PositionXYZOStream();

    if (mi->HasMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
    {
       data->appendPackGUID(mi->transport.guid);

       *data << mi->transport.pos.PositionXYZOStream();
       *data << mi->transport.time;
       *data << mi->transport.seat;

       if (mi->HasExtraMovementFlag(MOVEMENTFLAG2_INTERPOLATED_MOVEMENT))
           *data << mi->transport.time2;
    }

    if (mi->HasMovementFlag(MovementFlags(MOVEMENTFLAG_SWIMMING | MOVEMENTFLAG_FLYING)) || mi->HasExtraMovementFlag(MOVEMENTFLAG2_ALWAYS_ALLOW_PITCHING))
        *data << mi->pitch;

    *data << mi->fallTime;

    if (mi->HasMovementFlag(MOVEMENTFLAG_FALLING))
    {
        *data << mi->jump.zspeed;
        *data << mi->jump.sinAngle;
        *data << mi->jump.cosAngle;
        *data << mi->jump.xyspeed;
    }

    if (mi->HasMovementFlag(MOVEMENTFLAG_SPLINE_ELEVATION))
        *data << mi->splineElevation;
}

void WorldSession::ReadAddonsInfo(WorldPacket &data)
{
    if (data.rpos() + 4 > data.size())
        return;

    uint32 size;
    data >> size;

    if (!size)
        return;

    if (size > 0xFFFFF)
    {
        sLog->outError("WorldSession::ReadAddonsInfo addon info too big, size %u", size);
        return;
    }

    uLongf uSize = size;

    uint32 pos = data.rpos();

    ByteBuffer addonInfo;
    addonInfo.resize(size);

    if (uncompress(addonInfo.contents(), &uSize, data.contents() + pos, data.size() - pos) == Z_OK)
    {
        uint32 addonsCount;
        addonInfo >> addonsCount;                         // addons count

        for (uint32 i = 0; i < addonsCount; ++i)
        {
            std::string addonName;
            uint8 enabled;
            uint32 crc, unk1;

            // check next addon data format correctness
            if (addonInfo.rpos() + 1 > addonInfo.size())
                return;

            addonInfo >> addonName;

            addonInfo >> enabled >> crc >> unk1;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDetail("ADDON: Name: %s, Enabled: 0x%x, CRC: 0x%x, Unknown2: 0x%x", addonName.c_str(), enabled, crc, unk1);
#endif

            AddonInfo addon(addonName, enabled, crc, 2, true);

            SavedAddon const* savedAddon = AddonMgr::GetAddonInfo(addonName);
            if (savedAddon)
            {
                bool match = true;

                if (addon.CRC != savedAddon->CRC)
                    match = false;


#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                if (!match)
                    sLog->outDetail("ADDON: %s was known, but didn't match known CRC (0x%x)!", addon.Name.c_str(), savedAddon->CRC);
                else
                    sLog->outDetail("ADDON: %s was known, CRC is correct (0x%x)", addon.Name.c_str(), savedAddon->CRC);
#endif
            }
            else
            {
                AddonMgr::SaveAddon(addon);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDetail("ADDON: %s (0x%x) was not known, saving...", addon.Name.c_str(), addon.CRC);
#endif
            }

            // TODO: Find out when to not use CRC/pubkey, and other possible states.
            m_addonsList.push_back(addon);
        }

        uint32 currentTime;
        addonInfo >> currentTime;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "ADDON: CurrentTime: %u", currentTime);
#endif

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        if (addonInfo.rpos() != addonInfo.size())
            sLog->outDebug(LOG_FILTER_NETWORKIO, "packet under-read!");
#endif
    }
    else
        sLog->outError("Addon packet uncompress error!");
}

void WorldSession::SendAddonsInfo()
{
    uint8 addonPublicKey[256] =
    {
        0xC3, 0x5B, 0x50, 0x84, 0xB9, 0x3E, 0x32, 0x42, 0x8C, 0xD0, 0xC7, 0x48, 0xFA, 0x0E, 0x5D, 0x54,
        0x5A, 0xA3, 0x0E, 0x14, 0xBA, 0x9E, 0x0D, 0xB9, 0x5D, 0x8B, 0xEE, 0xB6, 0x84, 0x93, 0x45, 0x75,
        0xFF, 0x31, 0xFE, 0x2F, 0x64, 0x3F, 0x3D, 0x6D, 0x07, 0xD9, 0x44, 0x9B, 0x40, 0x85, 0x59, 0x34,
        0x4E, 0x10, 0xE1, 0xE7, 0x43, 0x69, 0xEF, 0x7C, 0x16, 0xFC, 0xB4, 0xED, 0x1B, 0x95, 0x28, 0xA8,
        0x23, 0x76, 0x51, 0x31, 0x57, 0x30, 0x2B, 0x79, 0x08, 0x50, 0x10, 0x1C, 0x4A, 0x1A, 0x2C, 0xC8,
        0x8B, 0x8F, 0x05, 0x2D, 0x22, 0x3D, 0xDB, 0x5A, 0x24, 0x7A, 0x0F, 0x13, 0x50, 0x37, 0x8F, 0x5A,
        0xCC, 0x9E, 0x04, 0x44, 0x0E, 0x87, 0x01, 0xD4, 0xA3, 0x15, 0x94, 0x16, 0x34, 0xC6, 0xC2, 0xC3,
        0xFB, 0x49, 0xFE, 0xE1, 0xF9, 0xDA, 0x8C, 0x50, 0x3C, 0xBE, 0x2C, 0xBB, 0x57, 0xED, 0x46, 0xB9,
        0xAD, 0x8B, 0xC6, 0xDF, 0x0E, 0xD6, 0x0F, 0xBE, 0x80, 0xB3, 0x8B, 0x1E, 0x77, 0xCF, 0xAD, 0x22,
        0xCF, 0xB7, 0x4B, 0xCF, 0xFB, 0xF0, 0x6B, 0x11, 0x45, 0x2D, 0x7A, 0x81, 0x18, 0xF2, 0x92, 0x7E,
        0x98, 0x56, 0x5D, 0x5E, 0x69, 0x72, 0x0A, 0x0D, 0x03, 0x0A, 0x85, 0xA2, 0x85, 0x9C, 0xCB, 0xFB,
        0x56, 0x6E, 0x8F, 0x44, 0xBB, 0x8F, 0x02, 0x22, 0x68, 0x63, 0x97, 0xBC, 0x85, 0xBA, 0xA8, 0xF7,
        0xB5, 0x40, 0x68, 0x3C, 0x77, 0x86, 0x6F, 0x4B, 0xD7, 0x88, 0xCA, 0x8A, 0xD7, 0xCE, 0x36, 0xF0,
        0x45, 0x6E, 0xD5, 0x64, 0x79, 0x0F, 0x17, 0xFC, 0x64, 0xDD, 0x10, 0x6F, 0xF3, 0xF5, 0xE0, 0xA6,
        0xC3, 0xFB, 0x1B, 0x8C, 0x29, 0xEF, 0x8E, 0xE5, 0x34, 0xCB, 0xD1, 0x2A, 0xCE, 0x79, 0xC3, 0x9A,
        0x0D, 0x36, 0xEA, 0x01, 0xE0, 0xAA, 0x91, 0x20, 0x54, 0xF0, 0x72, 0xD8, 0x1E, 0xC7, 0x89, 0xD2
    };

    WorldPacket data(SMSG_ADDON_INFO, 4);

    for (AddonsList::iterator itr = m_addonsList.begin(); itr != m_addonsList.end(); ++itr)
    {
        data << uint8(itr->State);

        uint8 crcpub = itr->UsePublicKeyOrCRC;
        data << uint8(crcpub);
        if (crcpub)
        {
            uint8 usepk = (itr->CRC != STANDARD_ADDON_CRC); // If addon is Standard addon CRC
            data << uint8(usepk);
            if (usepk)                                      // if CRC is wrong, add public key (client need it)
            {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDetail("ADDON: CRC (0x%x) for addon %s is wrong (does not match expected 0x%x), sending pubkey", itr->CRC, itr->Name.c_str(), STANDARD_ADDON_CRC);
#endif
                data.append(addonPublicKey, sizeof(addonPublicKey));
            }

            data << uint32(0);                              // TODO: Find out the meaning of this.
        }

        uint8 unk3 = 0;                                     // 0 is sent here
        data << uint8(unk3);
        if (unk3)
        {
            // String, length 256 (null terminated)
            data << uint8(0);
        }
    }

    m_addonsList.clear();

    AddonMgr::BannedAddonList const* bannedAddons = AddonMgr::GetBannedAddons();
    data << uint32(bannedAddons->size());
    for (AddonMgr::BannedAddonList::const_iterator itr = bannedAddons->begin(); itr != bannedAddons->end(); ++itr)
    {
	    data << uint32(itr->Id);
        data.append(itr->NameMD5, sizeof(itr->NameMD5));
        data.append(itr->VersionMD5, sizeof(itr->VersionMD5));
        data << uint32(itr->Timestamp);
        data << uint32(1);  // IsBanned
    }

    SendPacket(&data);
}

void WorldSession::SetPlayer(Player* player)
{
    _player = player;
    if (_player)
        m_GUIDLow = _player->GetGUIDLow();
}

void WorldSession::InitializeQueryCallbackParameters()
{
    // Callback parameters that have pointers in them should be properly
    // initialized to NULL here.
    _charCreateCallback.SetParam(nullptr);
    _loadPetFromDBFirstCallback.SetFirstParam(0);
    _loadPetFromDBFirstCallback.SetSecondParam(nullptr);
}

void WorldSession::ProcessQueryCallbacks()
{
    ProcessQueryCallbackPlayer();
    ProcessQueryCallbackPet();
    ProcessQueryCallbackLogin();
}

void WorldSession::ProcessQueryCallbackPlayer()
{
    PreparedQueryResult result;

    //- HandleCharRenameOpcode
    if (_charRenameCallback.IsReady())
    {
        std::string param = _charRenameCallback.GetParam();
        _charRenameCallback.GetResult(result);
        HandleChangePlayerNameOpcodeCallBack(result, param);
        _charRenameCallback.FreeResult();
    }

    //- HandleOpenItemOpcode
    if (_openWrappedItemCallback.IsReady())
    {
        uint8 bagIndex = _openWrappedItemCallback.GetFirstParam();
        uint8 slot = _openWrappedItemCallback.GetSecondParam();
        uint32 itemLowGUID = _openWrappedItemCallback.GetThirdParam();
        _openWrappedItemCallback.GetResult(result);
        HandleOpenWrappedItemCallback(result, bagIndex, slot, itemLowGUID);
        _openWrappedItemCallback.FreeResult();
    }

    //- Player - ActivateSpec
    if (_loadActionsSwitchSpecCallback.ready())
    {
        _loadActionsSwitchSpecCallback.get(result);
        HandleLoadActionsSwitchSpec(result);
        _loadActionsSwitchSpecCallback.cancel();
    }
}

void WorldSession::ProcessQueryCallbackPet()
{
    PreparedQueryResult result;

    //- SendStabledPet
    if (_sendStabledPetCallback.IsReady())
    {
        uint64 param = _sendStabledPetCallback.GetParam();
        _sendStabledPetCallback.GetResult(result);
        SendStablePetCallback(result, param);
        _sendStabledPetCallback.FreeResult();
        return;
    }

    //- HandleStablePet
    if (_stablePetCallback.ready())
    {
        _stablePetCallback.get(result);
        HandleStablePetCallback(result);
        _stablePetCallback.cancel();
        return;
    }

    //- HandleUnstablePet
    if (_unstablePetCallback.IsReady())
    {
        uint32 param = _unstablePetCallback.GetParam();
        _unstablePetCallback.GetResult(result);
        HandleUnstablePetCallback(result, param);
        _unstablePetCallback.FreeResult();
        return;
    }

    //- HandleStableSwapPet
    if (_stableSwapCallback.IsReady())
    {
        uint32 param = _stableSwapCallback.GetParam();
        _stableSwapCallback.GetResult(result);
        HandleStableSwapPetCallback(result, param);
        _stableSwapCallback.FreeResult();
        return;
    }

    //- LoadPetFromDB first part
    if (_loadPetFromDBFirstCallback.IsReady())
    {
        Player* player = GetPlayer();
        if (!player)
        {
            if (AsynchPetSummon* info = _loadPetFromDBFirstCallback.GetSecondParam())
                delete info;
            _loadPetFromDBFirstCallback.Reset();
            return;
        }
        // process only if player is in world (teleport crashes?)
        // otherwise wait with result till he logs in
        if (player->IsInWorld())
        {
            uint8 asynchLoadType = _loadPetFromDBFirstCallback.GetFirstParam();
            _loadPetFromDBFirstCallback.GetResult(result);

            uint8 loadResult = HandleLoadPetFromDBFirstCallback(result, asynchLoadType);
            if (loadResult != PET_LOAD_OK)
                Pet::HandleAsynchLoadFailed(_loadPetFromDBFirstCallback.GetSecondParam(), player, asynchLoadType, loadResult);

            if (AsynchPetSummon* info = _loadPetFromDBFirstCallback.GetSecondParam())
                delete info;
            _loadPetFromDBFirstCallback.Reset();
        }
        return;
    }

    //- LoadPetFromDB second part
    if (_loadPetFromDBSecondCallback.ready())
    {
        Player* player = GetPlayer();
        if (!player)
        {
            _loadPetFromDBSecondCallback.cancel();
        }
        else if (!player->IsInWorld())
        {
            // wait
        }
        else
        {
            SQLQueryHolder* param;
            _loadPetFromDBSecondCallback.get(param);
            HandleLoadPetFromDBSecondCallback((LoadPetFromDBQueryHolder*)param);
            delete param;
           _loadPetFromDBSecondCallback.cancel();
        }
        return;
    }
}

void WorldSession::ProcessQueryCallbackLogin()
{
    PreparedQueryResult result;

    //! HandleCharEnumOpcode
    if (_charEnumCallback.ready())
    {
        _charEnumCallback.get(result);
        HandleCharEnum(result);
        _charEnumCallback.cancel();
    }

    if (_charCreateCallback.IsReady())
    {
        _charCreateCallback.GetResult(result);
        HandleCharCreateCallback(result, _charCreateCallback.GetParam());
        // Don't call FreeResult() here, the callback handler will do that depending on the events in the callback chain
    }

    //! HandlePlayerLoginOpcode
    if (_charLoginCallback.ready())
    {
        SQLQueryHolder* param;
        _charLoginCallback.get(param);
        HandlePlayerLoginFromDB((LoginQueryHolder*)param);
        _charLoginCallback.cancel();
    }
}

void WorldSession::InitWarden(BigNumber* k, std::string const& os)
{
    if (os == "Win")
    {
        _warden = new WardenWin();
        _warden->Init(this, k);
    }
    else if (os == "OSX")
    {
        // Disabled as it is causing the client to crash
        // _warden = new WardenMac();
        // _warden->Init(this, k);
    }
}

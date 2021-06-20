/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AccountMgr.h"
#include "ByteBuffer.h"
#include "Common.h"
#include "CryptoHash.h"
#include "CryptoRandom.h"
#include "DatabaseEnv.h"
#include "IPLocation.h"
#include "Log.h"
#include "Opcodes.h"
#include "PacketLog.h"
#include "Player.h"
#include "Realm.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Util.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "WorldSocket.h"
#include "WorldSocketMgr.h"
#include <ace/Message_Block.h>
#include <ace/OS_NS_string.h>
#include <ace/OS_NS_unistd.h>
#include <ace/Reactor.h>
#include <ace/os_include/arpa/os_inet.h>
#include <ace/os_include/netinet/os_tcp.h>
#include <ace/os_include/sys/os_socket.h>
#include <ace/os_include/sys/os_types.h>
#include <thread>

#ifdef ELUNA
#include "LuaEngine.h"
#endif

#if defined(__GNUC__)
#pragma pack(1)
#else
#pragma pack(push, 1)
#endif

struct ServerPktHeader
{
    /**
     * size is the length of the payload _plus_ the length of the opcode
     */
    ServerPktHeader(uint32 size, uint16 cmd) : size(size)
    {
        uint8 headerIndex = 0;
        if (isLargePacket())
        {
            LOG_DEBUG("network", "initializing large server to client packet. Size: %u, cmd: %u", size, cmd);
            header[headerIndex++] = 0x80 | (0xFF & (size >> 16));
        }
        header[headerIndex++] = 0xFF & (size >> 8);
        header[headerIndex++] = 0xFF & size;

        header[headerIndex++] = 0xFF & cmd;
        header[headerIndex++] = 0xFF & (cmd >> 8);
    }

    uint8 getHeaderLength()
    {
        // cmd = 2 bytes, size= 2||3bytes
        return 2 + (isLargePacket() ? 3 : 2);
    }

    bool isLargePacket() const
    {
        return size > 0x7FFF;
    }

    const uint32 size;
    uint8 header[5];
};

struct ClientPktHeader
{
    uint16 size;
    uint32 cmd;
};

#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

struct AccountInfo
{
    uint32 Id;
    ::SessionKey SessionKey;
    std::string LastIP;
    bool IsLockedToIP;
    std::string LockCountry;
    uint8 Expansion;
    int64 MuteTime;
    LocaleConstant Locale;
    uint32 Recruiter;
    std::string OS;
    bool IsRectuiter;
    AccountTypes Security;
    bool IsBanned;
    uint32 TotalTime;

    explicit AccountInfo(Field* fields)
    {
        //           0             1          2         3               4            5           6         7            8     9           10          11
        // SELECT a.id, a.sessionkey, a.last_ip, a.locked, a.lock_country, a.expansion, a.mutetime, a.locale, a.recruiter, a.os, a.totaltime, aa.gmLevel,
        //                                                           12    13
        // ab.unbandate > UNIX_TIMESTAMP() OR ab.unbandate = ab.bandate, r.id
        // FROM account a
        // LEFT JOIN account_access aa ON a.id = aa.AccountID AND aa.RealmID IN (-1, ?)
        // LEFT JOIN account_banned ab ON a.id = ab.id
        // LEFT JOIN account r ON a.id = r.recruiter
        // WHERE a.username = ? ORDER BY aa.RealmID DESC LIMIT 1
        Id = fields[0].GetUInt32();
        SessionKey = fields[1].GetBinary<SESSION_KEY_LENGTH>();
        LastIP = fields[2].GetString();
        IsLockedToIP = fields[3].GetBool();
        LockCountry = fields[4].GetString();
        Expansion = fields[5].GetUInt8();
        MuteTime = fields[6].GetInt64();
        Locale = LocaleConstant(fields[7].GetUInt8());
        Recruiter = fields[8].GetUInt32();
        OS = fields[9].GetString();
        TotalTime = fields[10].GetUInt32();
        Security = AccountTypes(fields[11].GetUInt8());
        IsBanned = fields[12].GetUInt64() != 0;
        IsRectuiter = fields[13].GetUInt32() != 0;

        uint32 world_expansion = sWorld->getIntConfig(CONFIG_EXPANSION);
        if (Expansion > world_expansion)
            Expansion = world_expansion;

        if (Locale >= TOTAL_LOCALES)
            Locale = LOCALE_enUS;
    }
};

WorldSocket::WorldSocket(void): WorldHandler(),
    m_LastPingTime(SystemTimePoint::min()), m_OverSpeedPings(0), m_Session(0),
    m_RecvWPct(0), m_RecvPct(), m_Header(sizeof (ClientPktHeader)),
    m_OutBuffer(0), m_OutBufferSize(65536), m_OutActive(false)
{
    Acore::Crypto::GetRandomBytes(m_Seed);

    reference_counting_policy().value (ACE_Event_Handler::Reference_Counting_Policy::ENABLED);

    msg_queue()->high_water_mark(8 * 1024 * 1024);
    msg_queue()->low_water_mark(8 * 1024 * 1024);
}

WorldSocket::~WorldSocket(void)
{
    delete m_RecvWPct;

    if (m_OutBuffer)
        m_OutBuffer->release();

    closing_ = true;

    peer().close();
}

bool WorldSocket::IsClosed(void) const
{
    return closing_;
}

void WorldSocket::CloseSocket(std::string const& reason)
{
    if (!reason.empty())
        LOG_DEBUG("network", "Socket closed because of: %s", reason.c_str());

    {
        std::lock_guard<std::mutex> guard(m_OutBufferLock);

        if (closing_)
            return;

        closing_ = true;
        peer().close_writer();
    }

    {
        std::lock_guard<std::mutex> guard(m_SessionLock);

        m_Session = nullptr;
    }
}

const std::string& WorldSocket::GetRemoteAddress(void) const
{
    return m_Address;
}

int WorldSocket::SendPacket(WorldPacket const& pct)
{
    std::lock_guard<std::mutex> guard(m_OutBufferLock);

    if (closing_)
        return -1;

    // Dump outgoing packet.
    if (sPacketLog->CanLogPacket())
        sPacketLog->LogPacket(pct, SERVER_TO_CLIENT);

    ServerPktHeader header(pct.size() + 2, pct.GetOpcode());

    if (m_Crypt.IsInitialized())
        m_Crypt.EncryptSend((uint8*)header.header, header.getHeaderLength());

    if (m_OutBuffer->space() >= pct.size() + header.getHeaderLength() && msg_queue()->is_empty())
    {
        // Put the packet on the buffer.
        if (m_OutBuffer->copy((char*) header.header, header.getHeaderLength()) == -1)
            ABORT();

        if (!pct.empty())
            if (m_OutBuffer->copy((char*) pct.contents(), pct.size()) == -1)
                ABORT();
    }
    else
    {
        // Enqueue the packet.
        ACE_Message_Block* mb;

        ACE_NEW_RETURN(mb, ACE_Message_Block(pct.size() + header.getHeaderLength()), -1);

        mb->copy((char*) header.header, header.getHeaderLength());

        if (!pct.empty())
            mb->copy((const char*)pct.contents(), pct.size());

        if (msg_queue()->enqueue_tail(mb, (ACE_Time_Value*)&ACE_Time_Value::zero) == -1)
        {
            LOG_ERROR("server", "WorldSocket::SendPacket enqueue_tail failed");
            mb->release();
            return -1;
        }
    }

    return 0;
}

long WorldSocket::AddReference(void)
{
    return static_cast<long> (add_reference());
}

long WorldSocket::RemoveReference(void)
{
    return static_cast<long> (remove_reference());
}

int WorldSocket::open(void* a)
{
    ACE_UNUSED_ARG (a);

    // Prevent double call to this func.
    if (m_OutBuffer)
        return -1;

    // This will also prevent the socket from being Updated
    // while we are initializing it.
    m_OutActive = true;

    // Hook for the manager.
    if (sWorldSocketMgr->OnSocketOpen(this) == -1)
        return -1;

    // Allocate the buffer.
    ACE_NEW_RETURN (m_OutBuffer, ACE_Message_Block (m_OutBufferSize), -1);

    // Store peer address.
    ACE_INET_Addr remote_addr;

    if (peer().get_remote_addr(remote_addr) == -1)
    {
        LOG_ERROR("server", "WorldSocket::open: peer().get_remote_addr errno = %s", ACE_OS::strerror (errno));
        return -1;
    }

    m_Address = remote_addr.get_host_addr();

    // Send startup packet.
    WorldPacket packet (SMSG_AUTH_CHALLENGE, 24);
    packet << uint32(1);                                    // 1...31
    packet.append(m_Seed);
    packet.append(Acore::Crypto::GetRandomBytes<32>()); // new encryption seeds

    if (SendPacket(packet) == -1)
        return -1;

    // Register with ACE Reactor
    if (reactor()->register_handler(this, ACE_Event_Handler::READ_MASK | ACE_Event_Handler::WRITE_MASK) == -1)
    {
        LOG_ERROR("server", "WorldSocket::open: unable to register client handler errno = %s", ACE_OS::strerror (errno));
        return -1;
    }

    // reactor takes care of the socket from now on
    remove_reference();

    return 0;
}

int WorldSocket::close(u_long)
{
    shutdown();

    closing_ = true;

    remove_reference();

    return 0;
}

int WorldSocket::handle_input(ACE_HANDLE)
{
    if (closing_)
        return -1;

    switch (handle_input_missing_data())
    {
        case -1 :
            {
                if ((errno == EWOULDBLOCK) ||
                        (errno == EAGAIN))
                {
                    return Update();                           // interesting line, isn't it ?
                }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                LOG_DEBUG("server", "WorldSocket::handle_input: Peer error closing connection errno = %s", ACE_OS::strerror (errno));
#endif

                errno = ECONNRESET;
                return -1;
            }
        case 0:
            {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                LOG_DEBUG("server", "WorldSocket::handle_input: Peer has closed connection");
#endif

                errno = ECONNRESET;
                return -1;
            }
        case 1:
            return 1;
        default:
            return Update();                               // another interesting line ;)
    }

    return -1;
}

int WorldSocket::handle_output(ACE_HANDLE)
{
    if (closing_)
        return -1;

    std::lock_guard<std::mutex> guard(m_OutBufferLock);

    size_t send_len = m_OutBuffer->length();

    if (send_len == 0)
        return handle_output_queue();

#ifdef MSG_NOSIGNAL
    ssize_t n = peer().send (m_OutBuffer->rd_ptr(), send_len, MSG_NOSIGNAL);
#else
    ssize_t n = peer().send (m_OutBuffer->rd_ptr(), send_len);
#endif // MSG_NOSIGNAL

    if (n == 0)
        return -1;
    else if (n == -1)
    {
        if (errno == EWOULDBLOCK || errno == EAGAIN)
            return schedule_wakeup_output();

        return -1;
    }
    else if (n < (ssize_t)send_len) //now n > 0
    {
        m_OutBuffer->rd_ptr (static_cast<size_t> (n));

        // move the data to the base of the buffer
        m_OutBuffer->crunch();

        return schedule_wakeup_output();
    }
    else //now n == send_len
    {
        m_OutBuffer->reset();

        return handle_output_queue();
    }

    ACE_NOTREACHED (return 0);
}

int WorldSocket::handle_output_queue()
{
    if (msg_queue()->is_empty())
        return cancel_wakeup_output();

    ACE_Message_Block* mblk;

    if (msg_queue()->dequeue_head(mblk, (ACE_Time_Value*)&ACE_Time_Value::zero) == -1)
    {
        LOG_ERROR("server", "WorldSocket::handle_output_queue dequeue_head");
        return -1;
    }

    const size_t send_len = mblk->length();

#ifdef MSG_NOSIGNAL
    ssize_t n = peer().send(mblk->rd_ptr(), send_len, MSG_NOSIGNAL);
#else
    ssize_t n = peer().send(mblk->rd_ptr(), send_len);
#endif // MSG_NOSIGNAL

    if (n == 0)
    {
        mblk->release();

        return -1;
    }
    else if (n == -1)
    {
        if (errno == EWOULDBLOCK || errno == EAGAIN)
        {
            msg_queue()->enqueue_head(mblk, (ACE_Time_Value*) &ACE_Time_Value::zero);
            return schedule_wakeup_output();
        }

        mblk->release();
        return -1;
    }
    else if (n < (ssize_t)send_len) //now n > 0
    {
        mblk->rd_ptr(static_cast<size_t> (n));

        if (msg_queue()->enqueue_head(mblk, (ACE_Time_Value*) &ACE_Time_Value::zero) == -1)
        {
            LOG_ERROR("server", "WorldSocket::handle_output_queue enqueue_head");
            mblk->release();
            return -1;
        }

        return schedule_wakeup_output();
    }
    else //now n == send_len
    {
        mblk->release();

        return msg_queue()->is_empty() ? cancel_wakeup_output() : ACE_Event_Handler::WRITE_MASK;
    }

    return -1;
}

int WorldSocket::handle_close(ACE_HANDLE h, ACE_Reactor_Mask)
{
    // Critical section
    {
        std::lock_guard<std::mutex> guard(m_OutBufferLock);

        closing_ = true;

        if (h == ACE_INVALID_HANDLE)
            peer().close_writer();
    }

    // Critical section
    {
        std::lock_guard<decltype(m_SessionLock)> guard(m_SessionLock);

        m_Session = nullptr;
    }

    reactor()->remove_handler(this, ACE_Event_Handler::DONT_CALL | ACE_Event_Handler::ALL_EVENTS_MASK);
    return 0;
}

int WorldSocket::Update(void)
{
    if (closing_)
        return -1;

    if (m_OutActive)
        return 0;

    {
        std::lock_guard<std::mutex> guard(m_OutBufferLock);

        if (m_OutBuffer->length() == 0 && msg_queue()->is_empty())
            return 0;
    }

    int ret;
    do
        ret = handle_output (get_handle());
    while (ret > 0);

    return ret;
}

int WorldSocket::handle_input_header(void)
{
    ASSERT(m_RecvWPct == nullptr);
    ASSERT(m_Header.length() == sizeof(ClientPktHeader));

    if (m_Crypt.IsInitialized())
        m_Crypt.DecryptRecv((uint8*) m_Header.rd_ptr(), sizeof(ClientPktHeader));

    ClientPktHeader& header = *((ClientPktHeader*) m_Header.rd_ptr());

    EndianConvertReverse(header.size);
    EndianConvert(header.cmd);

    if ((header.size < 4) || (header.size > 10240) || (header.cmd > 10240))
    {
        LOG_ERROR("server", "WorldSocket::handle_input_header(): client (%s) sent malformed packet (size: %hd, cmd: %d)",
            GetRemoteAddress().c_str(), header.size, header.cmd);

        errno = EINVAL;
        return -1;
    }

    header.size -= 4;

    ACE_NEW_RETURN (m_RecvWPct, WorldPacket ((uint16) header.cmd, header.size), -1);

    if (header.size > 0)
    {
        m_RecvWPct->resize (header.size);
        m_RecvPct.base ((char*) m_RecvWPct->contents(), m_RecvWPct->size());
    }
    else
    {
        ASSERT(m_RecvPct.space() == 0);
    }

    return 0;
}

int WorldSocket::handle_input_payload(void)
{
    // set errno properly here on error !!!
    // now have a header and payload

    ASSERT(m_RecvPct.space() == 0);
    ASSERT(m_Header.space() == 0);
    ASSERT(m_RecvWPct != nullptr);

    const int ret = ProcessIncoming (m_RecvWPct);

    m_RecvPct.base (nullptr, 0);
    m_RecvPct.reset();
    m_RecvWPct = nullptr;

    m_Header.reset();

    if (ret == -1)
        errno = EINVAL;

    return ret;
}

int WorldSocket::handle_input_missing_data(void)
{
    char buf [4096];

    ACE_Data_Block db (sizeof (buf),
                       ACE_Message_Block::MB_DATA,
                       buf,
                       0,
                       0,
                       ACE_Message_Block::DONT_DELETE,
                       0);

    ACE_Message_Block message_block(&db,
                                    ACE_Message_Block::DONT_DELETE,
                                    0);

    const size_t recv_size = message_block.space();

    const ssize_t n = peer().recv (message_block.wr_ptr(),
                                   recv_size);

    if (n <= 0)
        return int(n);

    message_block.wr_ptr (n);

    while (message_block.length() > 0)
    {
        if (m_Header.space() > 0)
        {
            //need to receive the header
            const size_t to_header = (message_block.length() > m_Header.space() ? m_Header.space() : message_block.length());
            m_Header.copy (message_block.rd_ptr(), to_header);
            message_block.rd_ptr (to_header);

            if (m_Header.space() > 0)
            {
                // Couldn't receive the whole header this time.
                ASSERT(message_block.length() == 0);
                errno = EWOULDBLOCK;
                return -1;
            }

            // We just received nice new header
            if (handle_input_header() == -1)
            {
                ASSERT((errno != EWOULDBLOCK) && (errno != EAGAIN));
                return -1;
            }
        }

        // Its possible on some error situations that this happens
        // for example on closing when epoll receives more chunked data and stuff
        // hope this is not hack, as proper m_RecvWPct is asserted around
        if (!m_RecvWPct)
        {
            LOG_ERROR("server", "Forcing close on input m_RecvWPct = nullptr");
            errno = EINVAL;
            return -1;
        }

        // We have full read header, now check the data payload
        if (m_RecvPct.space() > 0)
        {
            //need more data in the payload
            const size_t to_data = (message_block.length() > m_RecvPct.space() ? m_RecvPct.space() : message_block.length());
            m_RecvPct.copy (message_block.rd_ptr(), to_data);
            message_block.rd_ptr (to_data);

            if (m_RecvPct.space() > 0)
            {
                // Couldn't receive the whole data this time.
                ASSERT(message_block.length() == 0);
                errno = EWOULDBLOCK;
                return -1;
            }
        }

        //just received fresh new payload
        if (handle_input_payload() == -1)
        {
            ASSERT((errno != EWOULDBLOCK) && (errno != EAGAIN));
            return -1;
        }
    }

    return size_t(n) == recv_size ? 1 : 2;
}

int WorldSocket::cancel_wakeup_output()
{
    if (!m_OutActive)
        return 0;

    m_OutActive = false;

    if (reactor()->cancel_wakeup
            (this, ACE_Event_Handler::WRITE_MASK) == -1)
    {
        // would be good to store errno from reactor with errno guard
        LOG_ERROR("server", "WorldSocket::cancel_wakeup_output");
        return -1;
    }

    return 0;
}

int WorldSocket::schedule_wakeup_output()
{
    if (m_OutActive)
        return 0;

    m_OutActive = true;

    if (reactor()->schedule_wakeup
            (this, ACE_Event_Handler::WRITE_MASK) == -1)
    {
        LOG_ERROR("server", "WorldSocket::schedule_wakeup_output");
        return -1;
    }

    return 0;
}

int WorldSocket::ProcessIncoming(WorldPacket* new_pct)
{
    ASSERT(new_pct);

    // manage memory ;)
    std::unique_ptr<WorldPacket> aptr(new_pct);

    OpcodeClient opcode = static_cast<OpcodeClient>(aptr->GetOpcode());

    if (closing_)
        return -1;

    // Dump received packet.
    if (sPacketLog->CanLogPacket())
        sPacketLog->LogPacket(*new_pct, CLIENT_TO_SERVER);

    try
    {
        switch (opcode)
        {
            case CMSG_PING:
                try
                {
                    return HandlePing(*new_pct);
                }
                catch (ByteBufferPositionException const&) { }
                 LOG_ERROR("server", "WorldSocket::ReadDataHandler(): client sent malformed CMSG_PING");
                return -1;
            case CMSG_AUTH_SESSION:
                if (m_Session)
                {
                    LOG_ERROR("server", "WorldSocket::ProcessIncoming: Player send CMSG_AUTH_SESSION again");
                    return -1;
                }
                return HandleAuthSession (*new_pct);
            case CMSG_KEEP_ALIVE:
                if (m_Session)
                    m_Session->ResetTimeOutTime(true);
                return 0;
            case CMSG_TIME_SYNC_RESP:
                new_pct = new WorldPacket(std::move(*new_pct), std::chrono::steady_clock::now());
                break;
            default:
                break;
        }
    }
    catch (ByteBufferException const&)
    {
        LOG_ERROR("server", "WorldSocket::ProcessIncoming ByteBufferException occured while parsing an instant handled packet (opcode: %u) from client %s, accountid=%u. Disconnected client.",
            aptr->GetOpcode(), GetRemoteAddress().c_str(), m_Session ? m_Session->GetAccountId() : 0);

        if (sLog->ShouldLog("network", LogLevel::LOG_LEVEL_DEBUG))
        {
            LOG_DEBUG("network", "Dumping error causing packet:");
            new_pct->hexlike();
        }

        return -1;
    }

    std::lock_guard<std::mutex> guard(m_SessionLock);

    OpcodeHandler const* handler = opcodeTable[opcode];
    if (!handler)
    {
        LOG_ERROR("network.opcode", "No defined handler for opcode %s sent by %s", GetOpcodeNameForLogging(static_cast<OpcodeClient>(aptr->GetOpcode())).c_str(), m_Session->GetPlayerInfo().c_str());
        return -1;
    }

    if (m_Session != nullptr)
    {
        // Our Idle timer will reset on any non PING or TIME_SYNC opcodes.
        // Catches people idling on the login screen and any lingering ingame connections.
        if (opcode != CMSG_PING && opcode != CMSG_TIME_SYNC_RESP)
        {
            m_Session->ResetTimeOutTime(false);
        }

        // OK, give the packet to WorldSession
        aptr.release();
        m_Session->QueuePacket(new_pct);
        return 0;
    }

    LOG_ERROR("server", "WorldSocket::ProcessIncoming: Client not authed opcode = %u", aptr->GetOpcode());
    return -1;
}

int WorldSocket::HandleAuthSession(WorldPacket& recvPacket)
{
    // NOTE: ATM the socket is singlethread, have this in mind ...
    uint32 loginServerID, loginServerType, regionID, battlegroupID, realmid;
    uint64 DosResponse;
    uint32 BuiltNumberClient;
    std::string accountName;
    WorldPacket packet, SendAddonPacked;
    std::array<uint8, 4> clientSeed;
    Acore::Crypto::SHA1::Digest digest;

    if (sWorld->IsClosed())
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_REJECT);
        SendPacket(packet);

        LOG_ERROR("server", "WorldSocket::HandleAuthSession: World closed, denying client (%s).", GetRemoteAddress().c_str());
        return -1;
    }

    // Read the content of the packet
    recvPacket >> BuiltNumberClient;                        // for now no use
    recvPacket >> loginServerID;
    recvPacket >> accountName;
    recvPacket >> loginServerType;
    recvPacket.read(clientSeed);
    recvPacket >> regionID;
    recvPacket >> battlegroupID;
    recvPacket >> realmid;
    recvPacket >> DosResponse;
    recvPacket.read(digest);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("server", "WorldSocket::HandleAuthSession: client %u, loginServerID %u, accountName %s, loginServerType %u",
        BuiltNumberClient, loginServerID, accountName.c_str(), loginServerType);
#endif
    // Get the account information from the realmd database
    //         0           1        2       3        4            5         6       7          8      9      10
    // SELECT id, sessionkey, last_ip, locked, lock_country, expansion, mutetime, locale, recruiter, os, totaltime FROM account WHERE username = ?
    auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_INFO_BY_NAME);
    stmt->setInt32(0, int32(realm.Id.Realm));
    stmt->setString(1, accountName);

    PreparedQueryResult result = LoginDatabase.Query(stmt);

    // Stop if the account is not found
    if (!result)
    {
        // We can not log here, as we do not know the account. Thus, no accountId.
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_UNKNOWN_ACCOUNT);

        SendPacket(packet);

        LOG_ERROR("server", "WorldSocket::HandleAuthSession: Sent Auth Response (unknown account).");
        return -1;
    }

    AccountInfo account(result->Fetch());

    // For hook purposes, we get Remoteaddress at this point
    std::string address = GetRemoteAddress(); // Originally, this variable should be called address, but for some reason, that variable name was already on the core.

    // As we don't know if attempted login process by ip works, we update last_attempt_ip right away
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_LAST_ATTEMPT_IP);
    stmt->setString(0, address);
    stmt->setString(1, accountName);
    LoginDatabase.Execute(stmt);
    // This also allows to check for possible "hack" attempts on account

    // even if auth credentials are bad, try using the session key we have - client cannot read auth response error without it
    m_Crypt.Init(account.SessionKey);

    // First reject the connection if packet contains invalid data or realm state doesn't allow logging in
    if (sWorld->IsClosed())
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_REJECT);
        SendPacket(packet);

        LOG_ERROR("server", "WorldSocket::HandleAuthSession: World closed, denying client (%s).", address.c_str());
        sScriptMgr->OnFailedAccountLogin(account.Id);
        return -1;
    }

    if (realmid != realm.Id.Realm)
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(REALM_LIST_REALM_NOT_FOUND);
        SendPacket(packet);

        LOG_ERROR("server", "WorldSocket::HandleAuthSession: Client %s requested connecting with realm id %u but this realm has id %u set in config.",
            address.c_str(), realmid, realm.Id.Realm);
        sScriptMgr->OnFailedAccountLogin(account.Id);
        return -1;
    }

    // Must be done before WorldSession is created
    bool wardenActive = sWorld->getBoolConfig(CONFIG_WARDEN_ENABLED);
    if (wardenActive && account.OS != "Win" && account.OS != "OSX")
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_REJECT);
        SendPacket(packet);
        LOG_ERROR("network", "WorldSocket::HandleAuthSession: Client %s attempted to log in using invalid client OS (%s).", address.c_str(), account.OS.c_str());
        sScriptMgr->OnFailedAccountLogin(account.Id);
        return -1;
    }

    // Check that Key and account name are the same on client and server
    uint8 t[4] = { 0x00, 0x00, 0x00, 0x00 };

    Acore::Crypto::SHA1 sha;
    sha.UpdateData(accountName);
    sha.UpdateData(t);
    sha.UpdateData(clientSeed);
    sha.UpdateData(m_Seed);
    sha.UpdateData(account.SessionKey);
    sha.Finalize();

    if (sha.GetDigest() != digest)
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_FAILED);

        SendPacket(packet);

        LOG_ERROR("server", "WorldSocket::HandleAuthSession: Authentication failed for account: %u ('%s') address: %s", account.Id, accountName.c_str(), address.c_str());
        return -1;
    }

    if (IpLocationRecord const* location = sIPLocation->GetLocationRecord(address))
        _ipCountry = location->CountryCode;

    ///- Re-check ip locking (same check as in auth).
    if (account.IsLockedToIP)
    {
        if (account.LastIP != address)
        {
            packet.Initialize(SMSG_AUTH_RESPONSE, 1);
            packet << uint8(AUTH_FAILED);
            SendPacket(packet);
            LOG_DEBUG("network", "WorldSocket::HandleAuthSession: Sent Auth Response (Account IP differs. Original IP: %s, new IP: %s).", account.LastIP.c_str(), address.c_str());
            // We could log on hook only instead of an additional db log, however action logger is config based. Better keep DB logging as well
            sScriptMgr->OnFailedAccountLogin(account.Id);
            return -1;
        }
    }
    else if (!account.LockCountry.empty() && account.LockCountry != "00" && !_ipCountry.empty())
    {
        if (account.LockCountry != _ipCountry)
        {
            packet.Initialize(SMSG_AUTH_RESPONSE, 1);
            packet << uint8(AUTH_REJECT);
            LOG_DEBUG("network", "WorldSocket::HandleAuthSession: Sent Auth Response (Account country differs. Original country: %s, new country: %s).", account.LockCountry.c_str(), _ipCountry.c_str());
            // We could log on hook only instead of an additional db log, however action logger is config based. Better keep DB logging as well
            sScriptMgr->OnFailedAccountLogin(account.Id);
            return -1;
        }
    }

    if (account.IsBanned)
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_BANNED);
        SendPacket(packet);
        LOG_ERROR("network", "WorldSocket::HandleAuthSession: Sent Auth Response (Account banned).");
        sScriptMgr->OnFailedAccountLogin(account.Id);
        return -1;
    }

    // Check locked state for server
    AccountTypes allowedAccountType = sWorld->GetPlayerSecurityLimit();
    LOG_DEBUG("network", "Allowed Level: %u Player Level %u", allowedAccountType, account.Security);
    if (allowedAccountType > SEC_PLAYER && account.Security < allowedAccountType)
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_UNAVAILABLE);
        LOG_DEBUG("network", "WorldSocket::HandleAuthSession: User tries to login but his security level is not enough");
        sScriptMgr->OnFailedAccountLogin(account.Id);
        return -1;
    }

    LOG_DEBUG("network", "WorldSocket::HandleAuthSession: Client '%s' authenticated successfully from %s.", accountName.c_str(), address.c_str());

    // Update the last_ip in the database as it was successful for login
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_LAST_IP);
    stmt->setString(0, address);
    stmt->setString(1, accountName);
    LoginDatabase.Execute(stmt);

    sScriptMgr->OnLastIpUpdate(account.Id, address);

    bool skipQueue = false;

    if (account.Security > SEC_PLAYER)
        skipQueue = true;

    // NOTE ATM the socket is single-threaded, have this in mind ...
    ACE_NEW_RETURN(m_Session,
        WorldSession(account.Id, this, AccountTypes(account.Security), account.Expansion, account.MuteTime, account.Locale, account.Recruiter, account.IsRectuiter, skipQueue, account.TotalTime), -1);

    m_Session->LoadGlobalAccountData();
    m_Session->LoadTutorialsData();
    m_Session->ReadAddonsInfo(recvPacket);

    // At this point, we can safely hook a successful login
    sScriptMgr->OnAccountLogin(account.Id);

    // Initialize Warden system only if it is enabled by config
    if (wardenActive)
        m_Session->InitWarden(account.SessionKey, account.OS);

    // Sleep this Network thread for
    uint32 sleepTime = sWorld->getIntConfig(CONFIG_SESSION_ADD_DELAY);
    std::this_thread::sleep_for(Microseconds(sleepTime));

    sWorld->AddSession(m_Session);

    return 0;
}

int WorldSocket::HandlePing(WorldPacket& recvPacket)
{
    uint32 ping;
    uint32 latency;

    // Get the ping packet content
    recvPacket >> ping;
    recvPacket >> latency;

    if (m_LastPingTime == SystemTimePoint::min())
        m_LastPingTime = std::chrono::system_clock::now(); // for 1st ping
    else
    {
        auto now = std::chrono::system_clock::now();
        Seconds seconds = std::chrono::duration_cast<Seconds>(now - m_LastPingTime);
        m_LastPingTime = now;

        if (seconds.count() < 27)
        {
            ++m_OverSpeedPings;

            uint32 max_count = sWorld->getIntConfig(CONFIG_MAX_OVERSPEED_PINGS);

            if (max_count && m_OverSpeedPings > max_count)
            {
                std::lock_guard<std::mutex> guard(m_SessionLock);

                if (m_Session && AccountMgr::IsPlayerAccount(m_Session->GetSecurity()))
                {
                    Player* _player = m_Session->GetPlayer();
                    LOG_ERROR("server", "WorldSocket::HandlePing: Player (account: %u, %s, name: %s) kicked for over-speed pings (address: %s)",
                                   m_Session->GetAccountId(),
                                   _player ? _player->GetGUID().ToString().c_str() : "",
                                   _player ? _player->GetName().c_str() : "<none>",
                                   GetRemoteAddress().c_str());

                    return -1;
                }
            }
        }
        else
            m_OverSpeedPings = 0;
    }

    // critical section
    {
        std::lock_guard<std::mutex> guard(m_SessionLock);

        if (m_Session)
        {
            m_Session->SetLatency (latency);
        }
        else
        {
            LOG_ERROR("server", "WorldSocket::HandlePing: peer sent CMSG_PING, "
                           "but is not authenticated or got recently kicked, "
                           " address = %s",
                           GetRemoteAddress().c_str());
            return -1;
        }
    }

    WorldPacket packet (SMSG_PONG, 4);
    packet << ping;
    return SendPacket(packet);
}

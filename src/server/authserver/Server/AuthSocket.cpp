/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include <algorithm>
#include <openssl/md5.h>

#include "Common.h"
#include "Database/DatabaseEnv.h"
#include "ByteBuffer.h"
#include "Configuration/Config.h"
#include "Log.h"
#include "RealmList.h"
#include "AuthSocket.h"
#include "AuthCodes.h"
#include "TOTP.h"
#include "SHA1.h"
#include "openssl/crypto.h"

#define ChunkSize 2048

enum eAuthCmd
{
    AUTH_LOGON_CHALLENGE                         = 0x00,
    AUTH_LOGON_PROOF                             = 0x01,
    AUTH_RECONNECT_CHALLENGE                     = 0x02,
    AUTH_RECONNECT_PROOF                         = 0x03,
    REALM_LIST                                   = 0x10,
    XFER_INITIATE                                = 0x30,
    XFER_DATA                                    = 0x31,
    XFER_ACCEPT                                  = 0x32,
    XFER_RESUME                                  = 0x33,
    XFER_CANCEL                                  = 0x34
};

// GCC have alternative #pragma pack(N) syntax and old gcc version not support pack(push, N), also any gcc version not support it at some paltform
#if defined(__GNUC__)
#pragma pack(1)
#else
#pragma pack(push, 1)
#endif

typedef struct AUTH_LOGON_CHALLENGE_C
{
    uint8   cmd;
    uint8   error;
    uint16  size;
    uint8   gamename[4];
    uint8   version1;
    uint8   version2;
    uint8   version3;
    uint16  build;
    uint8   platform[4];
    uint8   os[4];
    uint8   country[4];
    uint32  timezone_bias;
    uint32  ip;
    uint8   I_len;
    uint8   I[1];
} sAuthLogonChallenge_C;

typedef struct AUTH_LOGON_PROOF_C
{
    uint8   cmd;
    uint8   A[32];
    uint8   M1[20];
    uint8   crc_hash[20];
    uint8   number_of_keys;
    uint8   securityFlags;                                  // 0x00-0x04
} sAuthLogonProof_C;

typedef struct AUTH_LOGON_PROOF_S
{
    uint8   cmd;
    uint8   error;
    uint8   M2[20];
    uint32  unk1;
    uint32  unk2;
    uint16  unk3;
} sAuthLogonProof_S;

typedef struct AUTH_LOGON_PROOF_S_OLD
{
    uint8   cmd;
    uint8   error;
    uint8   M2[20];
    uint32  unk2;
} sAuthLogonProof_S_Old;

typedef struct AUTH_RECONNECT_PROOF_C
{
    uint8   cmd;
    uint8   R1[16];
    uint8   R2[20];
    uint8   R3[20];
    uint8   number_of_keys;
} sAuthReconnectProof_C;

typedef struct XFER_INIT
{
    uint8 cmd;                                              // XFER_INITIATE
    uint8 fileNameLen;                                      // strlen(fileName);
    uint8 fileName[5];                                      // fileName[fileNameLen]
    uint64 file_size;                                       // file size (bytes)
    uint8 md5[MD5_DIGEST_LENGTH];                           // MD5
} XFER_INIT;

typedef struct XFER_DATA
{
    uint8 opcode;
    uint16 data_size;
    uint8 data[ChunkSize];
} XFER_DATA_STRUCT;

typedef struct AuthHandler
{
    eAuthCmd cmd;
    uint32 status;
    bool (AuthSocket::*handler)(void);
} AuthHandler;

// GCC have alternative #pragma pack() syntax and old gcc version not support pack(pop), also any gcc version not support it at some paltform
#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

// Launch a thread to transfer a patch to the client
class PatcherRunnable: public acore::Runnable
{
public:
    PatcherRunnable(class AuthSocket*);
    void run();

private:
    AuthSocket* mySocket;
};

typedef struct PATCH_INFO
{
    uint8 md5[MD5_DIGEST_LENGTH];
} PATCH_INFO;

// Caches MD5 hash of client patches present on the server
class Patcher
{
public:
    typedef std::map<std::string, PATCH_INFO*> Patches;
    ~Patcher();
    Patcher();
    Patches::const_iterator begin() const { return _patches.begin(); }
    Patches::const_iterator end() const { return _patches.end(); }
    void LoadPatchMD5(char*);
    bool GetHash(char* pat, uint8 mymd5[16]);

private:
    void LoadPatchesInfo();
    Patches _patches;
};

const AuthHandler table[] =
{
    { AUTH_LOGON_CHALLENGE,     STATUS_CHALLENGE,   &AuthSocket::_HandleLogonChallenge      },
    { AUTH_LOGON_PROOF,         STATUS_LOGON_PROOF, &AuthSocket::_HandleLogonProof          },
    { AUTH_RECONNECT_CHALLENGE, STATUS_CHALLENGE,   &AuthSocket::_HandleReconnectChallenge  },
    { AUTH_RECONNECT_PROOF,     STATUS_RECON_PROOF, &AuthSocket::_HandleReconnectProof      },
    { REALM_LIST,               STATUS_AUTHED,      &AuthSocket::_HandleRealmList           },
    { XFER_ACCEPT,              STATUS_PATCH,       &AuthSocket::_HandleXferAccept          },
    { XFER_RESUME,              STATUS_PATCH,       &AuthSocket::_HandleXferResume          },
    { XFER_CANCEL,              STATUS_PATCH,       &AuthSocket::_HandleXferCancel          }
};

#define AUTH_TOTAL_COMMANDS 8

// Holds the MD5 hash of client patches present on the server
Patcher PatchesCache;

// Constructor - set the N and g values for SRP6
AuthSocket::AuthSocket(RealmSocket& socket) :
    pPatch(nullptr), socket_(socket), _status(STATUS_CHALLENGE), _build(0),
    _expversion(0), _accountSecurityLevel(SEC_PLAYER)
{
    N.SetHexStr("894B645E89E1535BBDAD5B8B290650530801B18EBFBF5E8FAB3C82872A3E9BB7");
    g.SetDword(7);
}

// Close patch file descriptor before leaving
AuthSocket::~AuthSocket(void) { }

// Accept the connection
void AuthSocket::OnAccept(void)
{
    sLog->outBasic("'%s:%d' Accepting connection", socket().getRemoteAddress().c_str(), socket().getRemotePort());
}

void AuthSocket::OnClose(void)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "AuthSocket::OnClose");
#endif
}

// Read the packet from the client
void AuthSocket::OnRead()
{
#define MAX_AUTH_LOGON_CHALLENGES_IN_A_ROW 3
    uint32 challengesInARow = 0;

#define MAX_AUTH_GET_REALM_LIST 10
    uint32 challengesInARowRealmList = 0;

    uint8 _cmd;
    while (1)
    {
        if (!socket().recv_soft((char*)&_cmd, 1))
            return;

        if (_cmd == AUTH_LOGON_CHALLENGE)
        {
            ++challengesInARow;
            if (challengesInARow == MAX_AUTH_LOGON_CHALLENGES_IN_A_ROW)
            {
                sLog->outString("Got %u AUTH_LOGON_CHALLENGE in a row from '%s', possible ongoing DoS", challengesInARow, socket().getRemoteAddress().c_str());
                socket().shutdown();
                return;
            }
        }
        else if (_cmd == REALM_LIST)
        {
            challengesInARowRealmList++;
            if (challengesInARowRealmList == MAX_AUTH_GET_REALM_LIST)
            {
                sLog->outString("Got %u REALM_LIST in a row from '%s', possible ongoing DoS", challengesInARowRealmList, socket().getRemoteAddress().c_str());
                socket().shutdown();
                return;
            }
        }

        size_t i;

        // Circle through known commands and call the correct command handler
        for (i = 0; i < AUTH_TOTAL_COMMANDS; ++i)
        {
            if ((uint8)table[i].cmd == _cmd && (table[i].status == _status))
            {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_NETWORKIO, "Got data for cmd %u recv length %u", (uint32)_cmd, (uint32)socket().recv_len());
#endif

                if (!(*this.*table[i].handler)())
                {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_NETWORKIO, "Command handler failed for cmd %u recv length %u", (uint32)_cmd, (uint32)socket().recv_len());
#endif
                    return;
                }
                break;
            }
        }

        // Report unknown packets in the error log
        if (i == AUTH_TOTAL_COMMANDS)
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_NETWORKIO, "Got unknown packet from '%s'", socket().getRemoteAddress().c_str());
#endif
            socket().shutdown();
            return;
        }
    }
}

// Make the SRP6 calculation from hash in dB
void AuthSocket::_SetVSFields(const std::string& rI)
{
    s.SetRand(s_BYTE_SIZE * 8);

    BigNumber I;
    I.SetHexStr(rI.c_str());

    // In case of leading zeros in the rI hash, restore them
    uint8 mDigest[SHA_DIGEST_LENGTH];
    memset(mDigest, 0, SHA_DIGEST_LENGTH);
    if (I.GetNumBytes() <= SHA_DIGEST_LENGTH)
        memcpy(mDigest, I.AsByteArray().get(), I.GetNumBytes());

    std::reverse(mDigest, mDigest + SHA_DIGEST_LENGTH);

    SHA1Hash sha;
    sha.UpdateData(s.AsByteArray().get(), s.GetNumBytes());
    sha.UpdateData(mDigest, SHA_DIGEST_LENGTH);
    sha.Finalize();
    BigNumber x;
    x.SetBinary(sha.GetDigest(), sha.GetLength());
    v = g.ModExp(x, N);

    // No SQL injection (username escaped)
    char* v_hex, *s_hex;
    v_hex = v.AsHexStr();
    s_hex = s.AsHexStr();

    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_VS);
    stmt->setString(0, v_hex);
    stmt->setString(1, s_hex);
    stmt->setString(2, _login);
    LoginDatabase.Execute(stmt);

    OPENSSL_free(v_hex);
    OPENSSL_free(s_hex);
}

std::map<std::string, uint32> LastLoginAttemptTimeForIP;
uint32 LastLoginAttemptCleanTime = 0;
ACE_Thread_Mutex LastLoginAttemptMutex;

// Logon Challenge command handler
bool AuthSocket::_HandleLogonChallenge()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Entering _HandleLogonChallenge");
#endif
    if (socket().recv_len() < sizeof(sAuthLogonChallenge_C))
        return false;

    ///- Session is closed unless overriden
    _status = STATUS_CLOSED;

    // pussywizard: logon flood protection:
    {
        ACORE_GUARD(ACE_Thread_Mutex, LastLoginAttemptMutex);
        std::string ipaddr = socket().getRemoteAddress();
        uint32 currTime = time(nullptr);
        std::map<std::string, uint32>::iterator itr = LastLoginAttemptTimeForIP.find(ipaddr);
        if (itr != LastLoginAttemptTimeForIP.end() && itr->second >= currTime)
        {
            ByteBuffer pkt;
            pkt << uint8(AUTH_LOGON_CHALLENGE);
            pkt << uint8(0x00);
            pkt << uint8(WOW_FAIL_UNKNOWN_ACCOUNT);
            socket().send((char const*)pkt.contents(), pkt.size());
            return true;
        }
        if (LastLoginAttemptCleanTime + 60 < currTime)
        {
            LastLoginAttemptTimeForIP.clear();
            LastLoginAttemptCleanTime = currTime;
        }
        else
            LastLoginAttemptTimeForIP[ipaddr] = currTime;
    }

    // Read the first 4 bytes (header) to get the length of the remaining of the packet
    std::vector<uint8> buf;
    buf.resize(4);

    socket().recv((char*)&buf[0], 4);

    EndianConvertPtr<uint16>(&buf[0]);

    uint16 remaining = ((sAuthLogonChallenge_C*)&buf[0])->size;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] got header, body is %#04x bytes", remaining);
#endif

    if ((remaining < sizeof(sAuthLogonChallenge_C) - buf.size()) || (socket().recv_len() < remaining))
        return false;

    //No big fear of memory outage (size is int16, i.e. < 65536)
    buf.resize(remaining + buf.size() + 1);
    buf[buf.size() - 1] = 0;
    sAuthLogonChallenge_C* ch = (sAuthLogonChallenge_C*)&buf[0];

    // Read the remaining of the packet
    socket().recv((char*)&buf[4], remaining);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] got full packet, %#04x bytes", ch->size);
    sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] name(%d): '%s'", ch->I_len, ch->I);
#endif

    // BigEndian code, nop in little endian case
    // size already converted
    EndianConvertPtr<uint32>(&ch->gamename[0]);
    EndianConvert(ch->build);
    EndianConvertPtr<uint32>(&ch->platform[0]);
    EndianConvertPtr<uint32>(&ch->os[0]);
    EndianConvertPtr<uint32>(&ch->country[0]);
    EndianConvert(ch->timezone_bias);
    EndianConvert(ch->ip);

    ByteBuffer pkt;

    _login = (const char*)ch->I;
    _build = ch->build;
    _expversion = uint8(AuthHelper::IsPostBCAcceptedClientBuild(_build) ? POST_BC_EXP_FLAG : (AuthHelper::IsPreBCAcceptedClientBuild(_build) ? PRE_BC_EXP_FLAG : NO_VALID_EXP_FLAG));
    _os = (const char*)ch->os;

    if (_os.size() > 4)
        return false;

    // Restore string order as its byte order is reversed
    std::reverse(_os.begin(), _os.end());

    pkt << uint8(AUTH_LOGON_CHALLENGE);
    pkt << uint8(0x00);

    // Verify that this IP is not in the ip_banned table
    LoginDatabase.Execute(LoginDatabase.GetPreparedStatement(LOGIN_DEL_EXPIRED_IP_BANS));

    std::string const& ip_address = socket().getRemoteAddress();
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_IP_BANNED);
    stmt->setString(0, ip_address);
    PreparedQueryResult result = LoginDatabase.Query(stmt);
    if (result)
    {
        pkt << uint8(WOW_FAIL_BANNED);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "'%s:%d' [AuthChallenge] Banned ip tries to login!", socket().getRemoteAddress().c_str(), socket().getRemotePort());
#endif
    }
    else
    {
        // Get the account details from the account table
        // No SQL injection (prepared statement)
        stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_LOGONCHALLENGE);
        stmt->setString(0, _login);

        PreparedQueryResult res2 = LoginDatabase.Query(stmt);
        if (res2)
        {
            Field* fields = res2->Fetch();

            // If the IP is 'locked', check that the player comes indeed from the correct IP address
            bool locked = false;
            if (fields[2].GetUInt8() == 1)                  // if ip is locked
            {
                sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] Account '%s' is locked to IP - '%s'", _login.c_str(), fields[3].GetCString());
                sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] Player address is '%s'", ip_address.c_str());

                if (strcmp(fields[4].GetCString(), ip_address.c_str()) != 0)
                {
                    sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] Account IP differs");
                    pkt << uint8(WOW_FAIL_LOCKED_ENFORCED);
                    locked = true;
                }
                else
                    sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] Account IP matches");
            }
            else
            {
                sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] Account '%s' is not locked to ip", _login.c_str());
                std::string accountCountry = fields[3].GetString();
                if (accountCountry.empty() || accountCountry == "00")
                    sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] Account '%s' is not locked to country", _login.c_str());
                else if (!accountCountry.empty())
                {
                    uint32 ip = inet_addr(ip_address.c_str());
                    EndianConvertReverse(ip);

                    stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_LOGON_COUNTRY);
                    stmt->setUInt32(0, ip);
                    if (PreparedQueryResult sessionCountryQuery = LoginDatabase.Query(stmt))
                    {
                        std::string loginCountry = (*sessionCountryQuery)[0].GetString();
                        sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] Account '%s' is locked to country: '%s' Player country is '%s'", _login.c_str(), accountCountry.c_str(), loginCountry.c_str());
                        if (loginCountry != accountCountry)
                        {
                            sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] Account country differs.");
                            pkt << uint8(WOW_FAIL_UNLOCKABLE_LOCK);
                            locked = true;
                        }
                        else
                            sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] Account country matches");
                    }
                    else
                        sLog->outDebug(LOG_FILTER_NETWORKIO, "[AuthChallenge] IP2NATION Table empty");
                }
            }

            if (!locked)
            {
                //set expired bans to inactive
                LoginDatabase.DirectExecute(LoginDatabase.GetPreparedStatement(LOGIN_UPD_EXPIRED_ACCOUNT_BANS));

                // If the account is banned, reject the logon attempt
                stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BANNED);
                stmt->setUInt32(0, fields[1].GetUInt32());
                PreparedQueryResult banresult = LoginDatabase.Query(stmt);
                if (banresult)
                {
                    if ((*banresult)[0].GetUInt32() == (*banresult)[1].GetUInt32())
                    {
                        pkt << uint8(WOW_FAIL_BANNED);
                        sLog->outDebug(LOG_FILTER_NETWORKIO, "'%s:%d' [AuthChallenge] Banned account %s tried to login!", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _login.c_str ());
                    }
                    else
                    {
                        pkt << uint8(WOW_FAIL_SUSPENDED);
                        sLog->outDebug(LOG_FILTER_NETWORKIO, "'%s:%d' [AuthChallenge] Temporarily banned account %s tried to login!", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _login.c_str ());
                    }
                }
                else
                {
                    // Get the password from the account table, upper it, and make the SRP6 calculation
                    std::string rI = fields[0].GetString();

                    // Don't calculate (v, s) if there are already some in the database
                    std::string databaseV = fields[6].GetString();
                    std::string databaseS = fields[7].GetString();

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_NETWORKIO, "database authentication values: v='%s' s='%s'", databaseV.c_str(), databaseS.c_str());
#endif

                    // multiply with 2 since bytes are stored as hexstring
                    if (databaseV.size() != s_BYTE_SIZE * 2 || databaseS.size() != s_BYTE_SIZE * 2)
                        _SetVSFields(rI);
                    else
                    {
                        s.SetHexStr(databaseS.c_str());
                        v.SetHexStr(databaseV.c_str());
                    }

                    b.SetRand(19 * 8);
                    BigNumber gmod = g.ModExp(b, N);
                    B = ((v * 3) + gmod) % N;

                    ASSERT(gmod.GetNumBytes() <= 32);

                    BigNumber unk3;
                    unk3.SetRand(16 * 8);

                    // Fill the response packet with the result
                    if (AuthHelper::IsAcceptedClientBuild(_build))
                        pkt << uint8(WOW_SUCCESS);
                    else
                        pkt << uint8(WOW_FAIL_VERSION_INVALID);

                    // B may be calculated < 32B so we force minimal length to 32B
                    pkt.append(B.AsByteArray(32).get(), 32);      // 32 bytes
                    pkt << uint8(1);
                    pkt.append(g.AsByteArray().get(), 1);
                    pkt << uint8(32);
                    pkt.append(N.AsByteArray(32).get(), 32);
                    pkt.append(s.AsByteArray().get(), s.GetNumBytes());   // 32 bytes
                    pkt.append(unk3.AsByteArray(16).get(), 16);
                    uint8 securityFlags = 0;

                    // Check if token is used
                    _tokenKey = fields[8].GetString();
                    if (!_tokenKey.empty())
                        securityFlags = 4;

                    pkt << uint8(securityFlags);            // security flags (0x0...0x04)

                    if (securityFlags & 0x01)               // PIN input
                    {
                        pkt << uint32(0);
                        pkt << uint64(0) << uint64(0);      // 16 bytes hash?
                    }

                    if (securityFlags & 0x02)               // Matrix input
                    {
                        pkt << uint8(0);
                        pkt << uint8(0);
                        pkt << uint8(0);
                        pkt << uint8(0);
                        pkt << uint64(0);
                    }

                    if (securityFlags & 0x04)               // Security token input
                        pkt << uint8(1);

                    uint8 secLevel = fields[5].GetUInt8();
                    _accountSecurityLevel = secLevel <= SEC_ADMINISTRATOR ? AccountTypes(secLevel) : SEC_ADMINISTRATOR;

                    _localizationName.resize(4);
                    for (int i = 0; i < 4; ++i)
                        _localizationName[i] = ch->country[4 - i - 1];


#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug( LOG_FILTER_NETWORKIO, "'%s:%d' [AuthChallenge] account %s is using '%c%c%c%c' locale (%u)", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _login.c_str (), ch->country[3], ch->country[2], ch->country[1], ch->country[0], GetLocaleByName(_localizationName) );
#endif

                    ///- All good, await client's proof
                    _status = STATUS_LOGON_PROOF;
                }
            }
        }
        else                                                //no account
            pkt << uint8(WOW_FAIL_UNKNOWN_ACCOUNT);
    }

    socket().send((char const*)pkt.contents(), pkt.size());
    return true;
}

// Logon Proof command handler
bool AuthSocket::_HandleLogonProof()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Entering _HandleLogonProof");
#endif
    // Read the packet
    sAuthLogonProof_C lp;

    if (!socket().recv((char*)&lp, sizeof(sAuthLogonProof_C)))
        return false;

    _status = STATUS_CLOSED;

    // If the client has no valid version
    if (_expversion == NO_VALID_EXP_FLAG)
    {
        // Check if we have the appropriate patch on the disk
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "Client with invalid version, patching is not implemented");
#endif
        socket().shutdown();
        return true;
    }

    // Continue the SRP6 calculation based on data received from the client
    BigNumber A;

    A.SetBinary(lp.A, 32);

    // SRP safeguard: abort if A == 0
    if ((A % N).isZero())
    {
        socket().shutdown();
        return true;
    }

    SHA1Hash sha;
    sha.UpdateBigNumbers(&A, &B, nullptr);
    sha.Finalize();
    BigNumber u;
    u.SetBinary(sha.GetDigest(), 20);
    BigNumber S = (A * (v.ModExp(u, N))).ModExp(b, N);

    uint8 t[32];
    uint8 t1[16];
    uint8 vK[40];
    memcpy(t, S.AsByteArray(32).get(), 32);

    for (int i = 0; i < 16; ++i)
        t1[i] = t[i * 2];

    sha.Initialize();
    sha.UpdateData(t1, 16);
    sha.Finalize();

    for (int i = 0; i < 20; ++i)
        vK[i * 2] = sha.GetDigest()[i];

    for (int i = 0; i < 16; ++i)
        t1[i] = t[i * 2 + 1];

    sha.Initialize();
    sha.UpdateData(t1, 16);
    sha.Finalize();

    for (int i = 0; i < 20; ++i)
        vK[i * 2 + 1] = sha.GetDigest()[i];

    K.SetBinary(vK, 40);

    uint8 hash[20];

    sha.Initialize();
    sha.UpdateBigNumbers(&N, nullptr);
    sha.Finalize();
    memcpy(hash, sha.GetDigest(), 20);
    sha.Initialize();
    sha.UpdateBigNumbers(&g, nullptr);
    sha.Finalize();

    for (int i = 0; i < 20; ++i)
        hash[i] ^= sha.GetDigest()[i];

    BigNumber t3;
    t3.SetBinary(hash, 20);

    sha.Initialize();
    sha.UpdateData(_login);
    sha.Finalize();
    uint8 t4[SHA_DIGEST_LENGTH];
    memcpy(t4, sha.GetDigest(), SHA_DIGEST_LENGTH);

    sha.Initialize();
    sha.UpdateBigNumbers(&t3, nullptr);
    sha.UpdateData(t4, SHA_DIGEST_LENGTH);
    sha.UpdateBigNumbers(&s, &A, &B, &K, nullptr);
    sha.Finalize();
    BigNumber M;
    M.SetBinary(sha.GetDigest(), 20);

    // Check if SRP6 results match (password is correct), else send an error
    if (!memcmp(M.AsByteArray().get(), lp.M1, 20))
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "'%s:%d' User '%s' successfully authenticated", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _login.c_str());
#endif

        // Update the sessionkey, last_ip, last login time and reset number of failed logins in the account table for this account
        // No SQL injection (escaped user name) and IP address as received by socket
        const char* K_hex = K.AsHexStr();

        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_LOGONPROOF);
        stmt->setString(0, K_hex);
        stmt->setString(1, socket().getRemoteAddress().c_str());
        stmt->setUInt32(2, GetLocaleByName(_localizationName));
        stmt->setString(3, _os);
        stmt->setString(4, _login);
        LoginDatabase.DirectExecute(stmt);

        OPENSSL_free((void*)K_hex);

        // Finish SRP6 and send the final result to the client
        sha.Initialize();
        sha.UpdateBigNumbers(&A, &M, &K, nullptr);
        sha.Finalize();

        // Check auth token
        if ((lp.securityFlags & 0x04) || !_tokenKey.empty())
        {
            uint8 size;
            socket().recv((char*)&size, 1);
            char* token = new char[size + 1];
            token[size] = '\0';
            socket().recv(token, size);
            unsigned int validToken = TOTP::GenerateToken(_tokenKey.c_str());
            unsigned int incomingToken = atoi(token);
            delete[] token;
            if (validToken != incomingToken)
            {
                char data[] = { AUTH_LOGON_PROOF, WOW_FAIL_UNKNOWN_ACCOUNT, 3, 0 };
                socket().send(data, sizeof(data));
                return false;
            }
        }

        if (_expversion & POST_BC_EXP_FLAG)                 // 2.x and 3.x clients
        {
            sAuthLogonProof_S proof;
            memcpy(proof.M2, sha.GetDigest(), 20);
            proof.cmd = AUTH_LOGON_PROOF;
            proof.error = 0;
            proof.unk1 = 0x00800000;    // Accountflags. 0x01 = GM, 0x08 = Trial, 0x00800000 = Pro pass (arena tournament)
            proof.unk2 = 0x00;          // SurveyId
            proof.unk3 = 0x00;
            socket().send((char*)&proof, sizeof(proof));
        }
        else
        {
            sAuthLogonProof_S_Old proof;
            memcpy(proof.M2, sha.GetDigest(), 20);
            proof.cmd = AUTH_LOGON_PROOF;
            proof.error = 0;
            proof.unk2 = 0x00;
            socket().send((char*)&proof, sizeof(proof));
        }

        ///- Set _status to authed!
        _status = STATUS_AUTHED;
    }
    else
    {
        char data[4] = { AUTH_LOGON_PROOF, WOW_FAIL_UNKNOWN_ACCOUNT, 3, 0 };
        socket().send(data, sizeof(data));

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "'%s:%d' [AuthChallenge] account %s tried to login with invalid password!", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _login.c_str());
#endif

        uint32 MaxWrongPassCount = sConfigMgr->GetIntDefault("WrongPass.MaxCount", 0);

        // We can not include the failed account login hook. However, this is a workaround to still log this.
        if (sConfigMgr->GetBoolDefault("WrongPass.Logging", false))
        {
            PreparedStatement* logstmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_FALP_IP_LOGGING);
            logstmt->setString(0, _login);
            logstmt->setString(1, socket().getRemoteAddress());
            logstmt->setString(2, "Logged on failed AccountLogin due wrong password");

            LoginDatabase.Execute(logstmt);
        }

        if (MaxWrongPassCount > 0)
        {
            //Increment number of failed logins by one and if it reaches the limit temporarily ban that account or IP
            PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_FAILEDLOGINS);
            stmt->setString(0, _login);
            LoginDatabase.Execute(stmt);

            stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_FAILEDLOGINS);
            stmt->setString(0, _login);

            if (PreparedQueryResult loginfail = LoginDatabase.Query(stmt))
            {
                uint32 failed_logins = (*loginfail)[1].GetUInt32();

                if (failed_logins >= MaxWrongPassCount)
                {
                    uint32 WrongPassBanTime = sConfigMgr->GetIntDefault("WrongPass.BanTime", 600);
                    bool WrongPassBanType = sConfigMgr->GetBoolDefault("WrongPass.BanType", false);

                    if (WrongPassBanType)
                    {
                        uint32 acc_id = (*loginfail)[0].GetUInt32();
                        stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_AUTO_BANNED);
                        stmt->setUInt32(0, acc_id);
                        stmt->setUInt32(1, WrongPassBanTime);
                        LoginDatabase.Execute(stmt);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                        sLog->outDebug(LOG_FILTER_NETWORKIO, "'%s:%d' [AuthChallenge] account %s got banned for '%u' seconds because it failed to authenticate '%u' times", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _login.c_str(), WrongPassBanTime, failed_logins);
#endif
                    }
                    else
                    {
                        stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_IP_AUTO_BANNED);
                        stmt->setString(0, socket().getRemoteAddress());
                        stmt->setUInt32(1, WrongPassBanTime);
                        LoginDatabase.Execute(stmt);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                        sLog->outDebug(LOG_FILTER_NETWORKIO, "'%s:%d' [AuthChallenge] IP %s got banned for '%u' seconds because account %s failed to authenticate '%u' times",
                                       socket().getRemoteAddress().c_str(), socket().getRemotePort(), socket().getRemoteAddress().c_str(), WrongPassBanTime, _login.c_str(), failed_logins);
#endif
                    }
                }
            }
        }
    }

    return true;
}

// Reconnect Challenge command handler
bool AuthSocket::_HandleReconnectChallenge()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Entering _HandleReconnectChallenge");
#endif
    if (socket().recv_len() < sizeof(sAuthLogonChallenge_C))
        return false;

    // Read the first 4 bytes (header) to get the length of the remaining of the packet
    std::vector<uint8> buf;
    buf.resize(4);

    socket().recv((char*)&buf[0], 4);

    EndianConvertPtr<uint16>(&buf[0]);

    uint16 remaining = ((sAuthLogonChallenge_C*)&buf[0])->size;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "[ReconnectChallenge] got header, body is %#04x bytes", remaining);
#endif

    if ((remaining < sizeof(sAuthLogonChallenge_C) - buf.size()) || (socket().recv_len() < remaining))
        return false;

    ///- Session is closed unless overriden
    _status = STATUS_CLOSED;

    // No big fear of memory outage (size is int16, i.e. < 65536)
    buf.resize(remaining + buf.size() + 1);
    buf[buf.size() - 1] = 0;
    sAuthLogonChallenge_C* ch = (sAuthLogonChallenge_C*)&buf[0];

    // Read the remaining of the packet
    socket().recv((char*)&buf[4], remaining);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "[ReconnectChallenge] got full packet, %#04x bytes", ch->size);
    sLog->outDebug(LOG_FILTER_NETWORKIO, "[ReconnectChallenge] name(%d): '%s'", ch->I_len, ch->I);
#endif

    _login = (const char*)ch->I;

    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_SESSIONKEY);
    stmt->setString(0, _login);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    // Stop if the account is not found
    if (!result)
    {
        sLog->outError("'%s:%d' [ERROR] user %s tried to login and we cannot find his session key in the database.", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _login.c_str());
        socket().shutdown();
        return false;
    }

    // Reinitialize build, expansion and the account securitylevel
    _build = ch->build;
    _expversion = uint8(AuthHelper::IsPostBCAcceptedClientBuild(_build) ? POST_BC_EXP_FLAG : (AuthHelper::IsPreBCAcceptedClientBuild(_build) ? PRE_BC_EXP_FLAG : NO_VALID_EXP_FLAG));
    _os = (const char*)ch->os;

    if (_os.size() > 4)
        return false;

    // Restore string order as its byte order is reversed
    std::reverse(_os.begin(), _os.end());

    Field* fields = result->Fetch();
    uint8 secLevel = fields[2].GetUInt8();
    _accountSecurityLevel = secLevel <= SEC_ADMINISTRATOR ? AccountTypes(secLevel) : SEC_ADMINISTRATOR;

    K.SetHexStr ((*result)[0].GetCString());

    ///- All good, await client's proof
    _status = STATUS_RECON_PROOF;

    // Sending response
    ByteBuffer pkt;
    pkt << uint8(AUTH_RECONNECT_CHALLENGE);
    pkt << uint8(0x00);
    _reconnectProof.SetRand(16 * 8);
    pkt.append(_reconnectProof.AsByteArray(16).get(), 16);        // 16 bytes random
    pkt << uint64(0x00) << uint64(0x00);                    // 16 bytes zeros
    socket().send((char const*)pkt.contents(), pkt.size());
    return true;
}

// Reconnect Proof command handler
bool AuthSocket::_HandleReconnectProof()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Entering _HandleReconnectProof");
#endif
    // Read the packet
    sAuthReconnectProof_C lp;
    if (!socket().recv((char*)&lp, sizeof(sAuthReconnectProof_C)))
        return false;

    _status = STATUS_CLOSED;

    if (_login.empty() || !_reconnectProof.GetNumBytes() || !K.GetNumBytes())
        return false;

    BigNumber t1;
    t1.SetBinary(lp.R1, 16);

    SHA1Hash sha;
    sha.Initialize();
    sha.UpdateData(_login);
    sha.UpdateBigNumbers(&t1, &_reconnectProof, &K, nullptr);
    sha.Finalize();

    if (!memcmp(sha.GetDigest(), lp.R2, SHA_DIGEST_LENGTH))
    {
        // Sending response
        ByteBuffer pkt;
        pkt << uint8(AUTH_RECONNECT_PROOF);
        pkt << uint8(0x00);
        pkt << uint16(0x00);                               // 2 bytes zeros
        socket().send((char const*)pkt.contents(), pkt.size());

        ///- Set _status to authed!
        _status = STATUS_AUTHED;

        return true;
    }
    else
    {
        sLog->outError("'%s:%d' [ERROR] user %s tried to login, but session is invalid.", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _login.c_str());
        socket().shutdown();
        return false;
    }
}

ACE_INET_Addr const& AuthSocket::GetAddressForClient(Realm const& realm, ACE_INET_Addr const& clientAddr)
{
    // Attempt to send best address for client
    if (clientAddr.is_loopback())
    {
        // Try guessing if realm is also connected locally
        if (realm.LocalAddress.is_loopback() || realm.ExternalAddress.is_loopback())
            return clientAddr;

        // Assume that user connecting from the machine that authserver is located on
        // has all realms available in his local network
        return realm.LocalAddress;
    }

    // Check if connecting client is in the same network
    if (IsIPAddrInNetwork(realm.LocalAddress, clientAddr, realm.LocalSubnetMask))
        return realm.LocalAddress;

    // Return external IP
    return realm.ExternalAddress;
}

// Realm List command handler
bool AuthSocket::_HandleRealmList()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Entering _HandleRealmList");
#endif
    if (socket().recv_len() < 5)
        return false;

    socket().recv_skip(5);

    // Get the user id (else close the connection)
    // No SQL injection (prepared statement)
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_ID_BY_NAME);
    stmt->setString(0, _login);
    PreparedQueryResult result = LoginDatabase.Query(stmt);
    if (!result)
    {
        sLog->outError("'%s:%d' [ERROR] user %s tried to login but we cannot find him in the database.", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _login.c_str());
        socket().shutdown();
        return false;
    }

    Field* fields = result->Fetch();
    uint32 id = fields[0].GetUInt32();

    // Update realm list if need
    sRealmList->UpdateIfNeed();

    ACE_INET_Addr clientAddr;
    socket().peer().get_remote_addr(clientAddr);

    // Circle through realms in the RealmList and construct the return packet (including # of user characters in each realm)
    ByteBuffer pkt;

    size_t RealmListSize = 0;
    for (RealmList::RealmMap::const_iterator i = sRealmList->begin(); i != sRealmList->end(); ++i)
    {
        const Realm& realm = i->second;
        // don't work with realms which not compatible with the client
        bool okBuild = ((_expversion & POST_BC_EXP_FLAG) && realm.gamebuild == _build) || ((_expversion & PRE_BC_EXP_FLAG) && !AuthHelper::IsPreBCAcceptedClientBuild(realm.gamebuild));

        // No SQL injection. id of realm is controlled by the database.
        uint32 flag = realm.flag;
        RealmBuildInfo const* buildInfo = AuthHelper::GetBuildInfo(realm.gamebuild);
        if (!okBuild)
        {
            if (!buildInfo)
                continue;

            flag |= REALM_FLAG_OFFLINE | REALM_FLAG_SPECIFYBUILD;   // tell the client what build the realm is for
        }

        if (!buildInfo)
            flag &= ~REALM_FLAG_SPECIFYBUILD;

        std::string name = i->first;
        if (_expversion & PRE_BC_EXP_FLAG && flag & REALM_FLAG_SPECIFYBUILD)
        {
            std::ostringstream ss;
            ss << name << " (" << buildInfo->MajorVersion << '.' << buildInfo->MinorVersion << '.' << buildInfo->BugfixVersion << ')';
            name = ss.str();
        }

        // We don't need the port number from which client connects with but the realm's port
        clientAddr.set_port_number(realm.ExternalAddress.get_port_number());

        uint8 lock = (realm.allowedSecurityLevel > _accountSecurityLevel) ? 1 : 0;

        uint8 AmountOfCharacters = 0;
        stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_NUM_CHARS_ON_REALM);
        stmt->setUInt32(0, realm.m_ID);
        stmt->setUInt32(1, id);
        result = LoginDatabase.Query(stmt);
        if (result)
            AmountOfCharacters = (*result)[0].GetUInt8();

        pkt << realm.icon;                                  // realm type
        if (_expversion & POST_BC_EXP_FLAG)                 // only 2.x and 3.x clients
            pkt << lock;                                    // if 1, then realm locked
        pkt << uint8(flag);                                 // RealmFlags
        pkt << name;
        pkt << GetAddressString(GetAddressForClient(realm, clientAddr));
        pkt << realm.populationLevel;
        pkt << AmountOfCharacters;
        pkt << realm.timezone;                              // realm category
        if (_expversion & POST_BC_EXP_FLAG)                 // 2.x and 3.x clients
            pkt << uint8(realm.m_ID);
        else
            pkt << uint8(0x0);                              // 1.12.1 and 1.12.2 clients

        if (_expversion & POST_BC_EXP_FLAG && flag & REALM_FLAG_SPECIFYBUILD)
        {
            pkt << uint8(buildInfo->MajorVersion);
            pkt << uint8(buildInfo->MinorVersion);
            pkt << uint8(buildInfo->BugfixVersion);
            pkt << uint16(buildInfo->Build);
        }

        ++RealmListSize;
    }

    if (_expversion & POST_BC_EXP_FLAG)                     // 2.x and 3.x clients
    {
        pkt << uint8(0x10);
        pkt << uint8(0x00);
    }
    else                                                    // 1.12.1 and 1.12.2 clients
    {
        pkt << uint8(0x00);
        pkt << uint8(0x02);
    }

    // make a ByteBuffer which stores the RealmList's size
    ByteBuffer RealmListSizeBuffer;
    RealmListSizeBuffer << uint32(0);
    if (_expversion & POST_BC_EXP_FLAG)                     // only 2.x and 3.x clients
        RealmListSizeBuffer << uint16(RealmListSize);
    else
        RealmListSizeBuffer << uint32(RealmListSize);

    ByteBuffer hdr;
    hdr << uint8(REALM_LIST);
    hdr << uint16(pkt.size() + RealmListSizeBuffer.size());
    hdr.append(RealmListSizeBuffer);                        // append RealmList's size buffer
    hdr.append(pkt);                                        // append realms in the realmlist

    socket().send((char const*)hdr.contents(), hdr.size());

    return true;
}

// Resume patch transfer
bool AuthSocket::_HandleXferResume()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Entering _HandleXferResume");
#endif
    // Check packet length and patch existence
    if (socket().recv_len() < 9 || !pPatch) // FIXME: pPatch is never used
    {
        sLog->outError("Error while resuming patch transfer (wrong packet)");
        return false;
    }

    // Launch a PatcherRunnable thread starting at given patch file offset
    uint64 start;
    socket().recv_skip(1);
    socket().recv((char*)&start, sizeof(start));
    fseek(pPatch, long(start), 0);

    acore::Thread u(new PatcherRunnable(this));
    return true;
}

// Cancel patch transfer
bool AuthSocket::_HandleXferCancel()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Entering _HandleXferCancel");
#endif

    // Close and delete the socket
    socket().recv_skip(1);                                         //clear input buffer
    socket().shutdown();

    return true;
}

// Accept patch transfer
bool AuthSocket::_HandleXferAccept()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Entering _HandleXferAccept");
#endif

    // Check packet length and patch existence
    if (!pPatch)
    {
        sLog->outError("Error while accepting patch transfer (wrong packet)");
        return false;
    }

    // Launch a PatcherRunnable thread, starting at the beginning of the patch file
    socket().recv_skip(1);                                         // clear input buffer
    fseek(pPatch, 0, 0);

    acore::Thread u(new PatcherRunnable(this));
    return true;
}

PatcherRunnable::PatcherRunnable(class AuthSocket* as)
{
    mySocket = as;
}

// Send content of patch file to the client
void PatcherRunnable::run() { }

// Preload MD5 hashes of existing patch files on server
#ifndef _WIN32
#include <dirent.h>
#include <errno.h>
void Patcher::LoadPatchesInfo()
{
    DIR* dirp;
    struct dirent* dp;
    dirp = opendir("./patches/");

    if (!dirp)
        return;

    while (dirp)
    {
        errno = 0;
        if ((dp = readdir(dirp)) != nullptr)
        {
            int l = strlen(dp->d_name);

            if (l < 8)
                continue;

            if (!memcmp(&dp->d_name[l - 4], ".mpq", 4))
                LoadPatchMD5(dp->d_name);
        }
        else
        {
            if (errno != 0)
            {
                closedir(dirp);
                return;
            }
            break;
        }
    }

    if (dirp)
        closedir(dirp);
}
#else
void Patcher::LoadPatchesInfo()
{
    WIN32_FIND_DATA fil;
    HANDLE hFil = FindFirstFile("./patches/*.mpq", &fil);
    if (hFil == INVALID_HANDLE_VALUE)
        return;                                             // no patches were found

    do
        LoadPatchMD5(fil.cFileName);
    while (FindNextFile(hFil, &fil));
}
#endif

// Calculate and store MD5 hash for a given patch file
void Patcher::LoadPatchMD5(char* szFileName)
{
    // Try to open the patch file
    std::string path = "./patches/";
    path += szFileName;
    FILE* pPatch = fopen(path.c_str(), "rb");
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Loading patch info from %s\n", path.c_str());
#endif

    if (!pPatch)
    {
        sLog->outError("Error loading patch %s\n", path.c_str());
        return;
    }

    // Calculate the MD5 hash
    MD5_CTX ctx;
    MD5_Init(&ctx);
    uint8* buf = new uint8[512 * 1024];

    while (!feof(pPatch))
    {
        size_t read = fread(buf, 1, 512 * 1024, pPatch);
        MD5_Update(&ctx, buf, read);
    }

    delete [] buf;
    fclose(pPatch);

    // Store the result in the internal patch hash map
    _patches[path] = new PATCH_INFO;
    MD5_Final((uint8*)&_patches[path]->md5, &ctx);
}

// Get cached MD5 hash for a given patch file
bool Patcher::GetHash(char* pat, uint8 mymd5[16])
{
    for (Patches::iterator i = _patches.begin(); i != _patches.end(); ++i)
        if (!stricmp(pat, i->first.c_str()))
        {
            memcpy(mymd5, i->second->md5, 16);
            return true;
        }

    return false;
}

// Launch the patch hashing mechanism on object creation
Patcher::Patcher()
{
    LoadPatchesInfo();
}

// Empty and delete the patch map on termination
Patcher::~Patcher()
{
    for (Patches::iterator i = _patches.begin(); i != _patches.end(); ++i)
        delete i->second;
}

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AuthSocket.h"
#include "AES.h"
#include "AuthCodes.h"
#include "ByteBuffer.h"
#include "Common.h"
#include "Config.h"
#include "CryptoGenerics.h"
#include "CryptoHash.h"
#include "CryptoRandom.h"
#include "DatabaseEnv.h"
#include "IPLocation.h"
#include "Log.h"
#include "RealmList.h"
#include "SecretMgr.h"
#include "TOTP.h"
#include "Threading.h"
#include <algorithm>
#include <openssl/crypto.h>
#include <openssl/md5.h>
#include <sstream>

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
    Acore::Crypto::SRP6::EphemeralKey A;
    Acore::Crypto::SHA1::Digest clientM;
    Acore::Crypto::SHA1::Digest crc_hash;
    uint8   number_of_keys;
    uint8   securityFlags;                                  // 0x00-0x04
} sAuthLogonProof_C;

typedef struct AUTH_LOGON_PROOF_S
{
    uint8   cmd;
    uint8   error;
    Acore::Crypto::SHA1::Digest M2;
    uint32  unk1;
    uint32  unk2;
    uint16  unk3;
} sAuthLogonProof_S;

typedef struct AUTH_LOGON_PROOF_S_OLD
{
    uint8   cmd;
    uint8   error;
    Acore::Crypto::SHA1::Digest M2;
    uint32  unk2;
} sAuthLogonProof_S_Old;

typedef struct AUTH_RECONNECT_PROOF_C
{
    uint8   cmd;
    uint8   R1[16];
    Acore::Crypto::SHA1::Digest R2, R3;
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
    bool (AuthSocket::*handler)();
} AuthHandler;

// GCC have alternative #pragma pack() syntax and old gcc version not support pack(pop), also any gcc version not support it at some paltform
#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

// Launch a thread to transfer a patch to the client
class PatcherRunnable: public Acore::Runnable
{
public:
    PatcherRunnable(class AuthSocket*);
    void run() override;

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
    [[nodiscard]] Patches::const_iterator begin() const { return _patches.begin(); }
    [[nodiscard]] Patches::const_iterator end() const { return _patches.end(); }
    void LoadPatchMD5(char*);
    bool GetHash(char* pat, uint8 mymd5[16]);

private:
    void LoadPatchesInfo();
    Patches _patches;
};

std::array<uint8, 16> VersionChallenge = { { 0xBA, 0xA3, 0x1E, 0x99, 0xA0, 0x0B, 0x21, 0x57, 0xFC, 0x37, 0x3F, 0xB3, 0x69, 0xCD, 0xD2, 0xF1 } };

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

void AccountInfo::LoadResult(Field* fields)
{
    //          0           1         2               3          4                5                                                             6
    //SELECT a.id, a.username, a.locked, a.lock_country, a.last_ip, a.failed_logins, ab.unbandate > UNIX_TIMESTAMP() OR ab.unbandate = ab.bandate,
    //                               7           8
    //       ab.unbandate = ab.bandate, aa.gmlevel (, more query-specific fields)
    //FROM account a LEFT JOIN account_access aa ON a.id = aa.AccountID LEFT JOIN account_banned ab ON ab.id = a.id AND ab.active = 1 WHERE a.username = ?

    Id = fields[0].GetUInt32();
    Login = fields[1].GetString();
    IsLockedToIP = fields[2].GetBool();
    LockCountry = fields[3].GetString();
    LastIP = fields[4].GetString();
    FailedLogins = fields[5].GetUInt32();
    IsBanned = fields[6].GetUInt64() != 0;
    IsPermanenetlyBanned = fields[7].GetUInt64() != 0;
    SecurityLevel = static_cast<AccountTypes>(fields[8].GetUInt8()) > SEC_CONSOLE ? SEC_CONSOLE : static_cast<AccountTypes>(fields[8].GetUInt8());

    // Use our own uppercasing of the account name instead of using UPPER() in mysql query
    // This is how the account was created in the first place and changing it now would result in breaking
    // login for all accounts having accented characters in their name
    Utf8ToUpperOnlyLatin(Login);
}

// Holds the MD5 hash of client patches present on the server
Patcher PatchesCache;

// Constructor - set the N and g values for SRP6
AuthSocket::AuthSocket(RealmSocket& socket) :
    pPatch(nullptr), socket_(socket), _status(STATUS_CHALLENGE), _build(0),
    _expversion(0)
{
}

// Close patch file descriptor before leaving
AuthSocket::~AuthSocket() = default;

// Accept the connection
void AuthSocket::OnAccept()
{
    LOG_INFO("server", "'%s:%d' Accepting connection", socket().getRemoteAddress().c_str(), socket().getRemotePort());
}

void AuthSocket::OnClose()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "AuthSocket::OnClose");
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
    while (true)
    {
        if (!socket().recv_soft((char*)&_cmd, 1))
            return;

        if (_cmd == AUTH_LOGON_CHALLENGE)
        {
            ++challengesInARow;
            if (challengesInARow == MAX_AUTH_LOGON_CHALLENGES_IN_A_ROW)
            {
                LOG_INFO("server", "Got %u AUTH_LOGON_CHALLENGE in a row from '%s', possible ongoing DoS", challengesInARow, socket().getRemoteAddress().c_str());
                socket().shutdown();
                return;
            }
        }
        else if (_cmd == REALM_LIST)
        {
            challengesInARowRealmList++;
            if (challengesInARowRealmList == MAX_AUTH_GET_REALM_LIST)
            {
                LOG_INFO("server", "Got %u REALM_LIST in a row from '%s', possible ongoing DoS", challengesInARowRealmList, socket().getRemoteAddress().c_str());
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
                LOG_DEBUG("network", "Got data for cmd %u recv length %u", (uint32)_cmd, (uint32)socket().recv_len());
#endif

                if (!(*this.*table[i].handler)())
                {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    LOG_DEBUG("network", "Command handler failed for cmd %u recv length %u", (uint32)_cmd, (uint32)socket().recv_len());
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
            LOG_DEBUG("network", "Got unknown packet from '%s'", socket().getRemoteAddress().c_str());
#endif
            socket().shutdown();
            return;
        }
    }
}

std::map<std::string, uint32> LastLoginAttemptTimeForIP;
uint32 LastLoginAttemptCleanTime = 0;
std::mutex LastLoginAttemptMutex;

// Logon Challenge command handler
bool AuthSocket::_HandleLogonChallenge()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Entering _HandleLogonChallenge");
#endif
    if (socket().recv_len() < sizeof(sAuthLogonChallenge_C))
        return false;

    ///- Session is closed unless overriden
    _status = STATUS_CLOSED;

    // Read the first 4 bytes (header) to get the length of the remaining of the packet
    std::vector<uint8> buf;
    buf.resize(4);

    socket().recv((char*)&buf[0], 4);

    EndianConvertPtr<uint16>(&buf[0]);

    uint16 remaining = ((sAuthLogonChallenge_C*)&buf[0])->size;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "[AuthChallenge] got header, body is %#04x bytes", remaining);
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
    LOG_DEBUG("network", "[AuthChallenge] got full packet, %#04x bytes", ch->size);
    LOG_DEBUG("network", "[AuthChallenge] name(%d): '%s'", ch->I_len, ch->I);
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

    std::string login((char const*)ch->I, ch->I_len);
    LOG_DEBUG("server.authserver", "[AuthChallenge] '%s'", login.c_str());

    _build = ch->build;
    _expversion = uint8(AuthHelper::IsPostBCAcceptedClientBuild(_build) ? POST_BC_EXP_FLAG : (AuthHelper::IsPreBCAcceptedClientBuild(_build) ? PRE_BC_EXP_FLAG : NO_VALID_EXP_FLAG));
    _os = (const char*)ch->os;

    if (_os.size() > 4)
        return false;

    // Restore string order as its byte order is reversed
    std::reverse(_os.begin(), _os.end());

    _localizationName.resize(4);
    for (int i = 0; i < 4; ++i)
        _localizationName[i] = ch->country[4 - i - 1];

    ByteBuffer pkt;
    pkt << uint8(AUTH_LOGON_CHALLENGE);
    pkt << uint8(0x00);

    auto SendAuthPacket = [&]()
    {
        socket().send((char const*)pkt.contents(), pkt.size());
    };

    // Verify that this IP is not in the ip_banned table
    LoginDatabase.Execute(LoginDatabase.GetPreparedStatement(LOGIN_DEL_EXPIRED_IP_BANS));

    std::string const& ipAddress = socket().getRemoteAddress();
    uint32 port = socket().getRemotePort();

    // Get the account details from the account table
    // No SQL injection (prepared statement)
    auto stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_LOGONCHALLENGE);
    stmt->setString(0, login);

    PreparedQueryResult res2 = LoginDatabase.Query(stmt);
    if (!res2) //no account
    {
        pkt << uint8(WOW_FAIL_UNKNOWN_ACCOUNT);
        SendAuthPacket();
        return true;
    }

    Field* fields = res2->Fetch();

    _accountInfo.LoadResult(fields);

    // If the IP is 'locked', check that the player comes indeed from the correct IP address
    if (_accountInfo.IsLockedToIP)
    {
        LOG_DEBUG("server.authserver", "[AuthChallenge] Account '%s' is locked to IP - '%s' is logging in from '%s'", _accountInfo.Login.c_str(), _accountInfo.LastIP.c_str(), ipAddress.c_str());

        if (_accountInfo.LastIP != ipAddress)
        {
            LOG_DEBUG("network", "[AuthChallenge] Account IP differs");
            pkt << uint8(WOW_FAIL_LOCKED_ENFORCED);
            SendAuthPacket();
            return true;
        }
    }
    else
    {
        if (IpLocationRecord const* location = sIPLocation->GetLocationRecord(ipAddress))
            _ipCountry = location->CountryCode;

        LOG_DEBUG("server.authserver", "[AuthChallenge] Account '%s' is not locked to ip", _accountInfo.Login.c_str());
        if (_accountInfo.LockCountry.empty() || _accountInfo.LockCountry == "00")
            LOG_DEBUG("server.authserver", "[AuthChallenge] Account '%s' is not locked to country", _accountInfo.Login.c_str());
        else if (!_ipCountry.empty())
        {
            LOG_DEBUG("server.authserver", "[AuthChallenge] Account '%s' is locked to country: '%s' Player country is '%s'", _accountInfo.Login.c_str(), _accountInfo.LockCountry.c_str(), _ipCountry.c_str());
            if (_ipCountry != _accountInfo.LockCountry)
            {
                pkt << uint8(WOW_FAIL_UNLOCKABLE_LOCK);
                SendAuthPacket();
                return true;
            }
        }
    }

    // If the account is banned, reject the logon attempt
    if (_accountInfo.IsBanned)
    {
        if (_accountInfo.IsPermanenetlyBanned)
        {
            pkt << uint8(WOW_FAIL_BANNED);
            LOG_DEBUG("server.authserver.banned", "'%s:%d' [AuthChallenge] Banned account %s tried to login!", ipAddress.c_str(), port, _accountInfo.Login.c_str());
        }
        else
        {
            pkt << uint8(WOW_FAIL_SUSPENDED);
            LOG_DEBUG("server.authserver.banned", "'%s:%d' [AuthChallenge] Temporarily banned account %s tried to login!", ipAddress.c_str(), port, _accountInfo.Login.c_str());
        }

        SendAuthPacket();
        return true;
    }

    uint8 securityFlags = 0;

    // Check if a TOTP token is needed
    if (sConfigMgr->GetOption<bool>("EnableTOTP", false) && !fields[9].IsNull())
    {
        LOG_DEBUG("server.authserver", "[AuthChallenge] Account '%s' using TOTP", _accountInfo.Login.c_str());

        securityFlags = 4;
        _totpSecret = fields[9].GetBinary();
        if (auto const& secret = sSecretMgr->GetSecret(SECRET_TOTP_MASTER_KEY))
        {
            bool success = Acore::Crypto::AEDecrypt<Acore::Crypto::AES>(*_totpSecret, *secret);
            if (!success)
            {
                pkt << uint8(WOW_FAIL_DB_BUSY);
                LOG_ERROR("server.authserver", "[AuthChallenge] Account '%s' has invalid ciphertext for TOTP token key stored", _accountInfo.Login.c_str());
                SendAuthPacket();
                return true;
            }
        }
    }

    _srp6.emplace(
        _accountInfo.Login,
        fields[10].GetBinary<Acore::Crypto::SRP6::SALT_LENGTH>(),
        fields[11].GetBinary<Acore::Crypto::SRP6::VERIFIER_LENGTH>());

    // Fill the response packet with the result
    if (!AuthHelper::IsAcceptedClientBuild(_build))
    {
        pkt << uint8(WOW_FAIL_VERSION_INVALID);
        SendAuthPacket();
        return true;
    }

    pkt << uint8(WOW_SUCCESS);

    // B may be calculated < 32B so we force minimal length to 32B
    pkt.append(_srp6->B);
    pkt << uint8(1);
    pkt.append(_srp6->g);
    pkt << uint8(32);
    pkt.append(_srp6->N);
    pkt.append(_srp6->s);
    pkt.append(VersionChallenge.data(), VersionChallenge.size());
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

    LOG_DEBUG("server.authserver", "'%s:%d' [AuthChallenge] account %s is using locale (%u)",
        ipAddress.c_str(), port, _accountInfo.Login.c_str(), GetLocaleByName(_localizationName));

    ///- All good, await client's proof
    _status = STATUS_LOGON_PROOF;

    SendAuthPacket();
    return true;
}

// Logon Proof command handler
bool AuthSocket::_HandleLogonProof()
{
    LOG_TRACE("server.authserver", "Entering _HandleLogonProof");

    // Read the packet
    sAuthLogonProof_C lp;

    if (!socket().recv((char*)&lp, sizeof(sAuthLogonProof_C)))
    {
        return false;
    }

    _status = STATUS_CLOSED;

    // If the client has no valid version
    if (_expversion == NO_VALID_EXP_FLAG)
    {
        // Check if we have the appropriate patch on the disk
        LOG_DEBUG("network", "Client with invalid version, patching is not implemented");
        socket().shutdown();
        return true;
    }

    if (std::optional<SessionKey> K = _srp6->VerifyChallengeResponse(lp.A, lp.clientM))
    {
        _sessionKey = *K;

        // Check auth token
        bool tokenSuccess = false;
        bool sentToken = (lp.securityFlags & 0x04);

        if (sentToken && _totpSecret)
        {
            uint8 size;
            socket().recv((char*)&size, 1);
            char* token = new char[size + 1];
            token[size] = '\0';
            socket().recv(token, size);
            unsigned int incomingToken = atoi(token);
            delete[] token;

            tokenSuccess = Acore::Crypto::TOTP::ValidateToken(*_totpSecret, incomingToken);
            memset(_totpSecret->data(), 0, _totpSecret->size());
        }
        else if (!sentToken && !_totpSecret)
            tokenSuccess = true;

        if (!tokenSuccess)
        {
            LOG_DEBUG("server.authsrver", "[AuthChallenge] account %s failed token", _accountInfo.Login.c_str());
            char data[4] = { AUTH_LOGON_PROOF, WOW_FAIL_UNKNOWN_ACCOUNT, 3, 0 };
            socket().send(data, sizeof(data));
        }

        LOG_DEBUG("network", "'%s:%d' User '%s' successfully authenticated", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _accountInfo.Login.c_str());

        // Update the sessionkey, last_ip, last login time and reset number of failed logins in the account table for this account
        // No SQL injection (escaped user name) and IP address as received by socket
        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_LOGONPROOF);
        stmt->setBinary(0, _sessionKey);
        stmt->setString(1, socket().getRemoteAddress().c_str());
        stmt->setUInt32(2, GetLocaleByName(_localizationName));
        stmt->setString(3, _os);
        stmt->setString(4, _accountInfo.Login);
        LoginDatabase.DirectExecute(stmt);

        // Finish SRP6 and send the final result to the client
        Acore::Crypto::SHA1::Digest M2 = Acore::Crypto::SRP6::GetSessionVerifier(lp.A, lp.clientM, _sessionKey);

        if (_expversion & POST_BC_EXP_FLAG)                 // 2.x and 3.x clients
        {
            sAuthLogonProof_S proof;
            proof.M2 = M2;
            proof.cmd = AUTH_LOGON_PROOF;
            proof.error = 0;
            proof.unk1 = 0x00800000;    // Accountflags. 0x01 = GM, 0x08 = Trial, 0x00800000 = Pro pass (arena tournament)
            proof.unk2 = 0x00;          // SurveyId
            proof.unk3 = 0x00;          // 0x1 = has account message
            socket().send((char*)&proof, sizeof(proof));
        }
        else
        {
            sAuthLogonProof_S_Old proof;
            proof.M2 = M2;
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

        LOG_INFO("server.authserver.hack", "'%s:%d' [AuthChallenge] account %s tried to login with invalid password!",
            socket().getRemoteAddress().c_str(), socket().getRemotePort(), _accountInfo.Login.c_str());

        uint32 MaxWrongPassCount = sConfigMgr->GetOption<int32>("WrongPass.MaxCount", 0);

        // We can not include the failed account login hook. However, this is a workaround to still log this.
        if (sConfigMgr->GetOption<bool>("WrongPass.Logging", false))
        {
            PreparedStatement* logstmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_FALP_IP_LOGGING);
            logstmt->setString(0, _accountInfo.Login);
            logstmt->setString(1, socket().getRemoteAddress());
            logstmt->setString(2, "Logged on failed AccountLogin due wrong password");

            LoginDatabase.Execute(logstmt);
        }

        if (MaxWrongPassCount > 0)
        {
            //Increment number of failed logins by one and if it reaches the limit temporarily ban that account or IP
            PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_FAILEDLOGINS);
            stmt->setString(0, _accountInfo.Login);
            LoginDatabase.Execute(stmt);

            if (++_accountInfo.FailedLogins >= MaxWrongPassCount)
            {
                uint32 WrongPassBanTime = sConfigMgr->GetOption<int32>("WrongPass.BanTime", 600);
                bool WrongPassBanType = sConfigMgr->GetOption<bool>("WrongPass.BanType", false);

                if (WrongPassBanType)
                {
                    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_AUTO_BANNED);
                    stmt->setUInt32(0, _accountInfo.Id);
                    stmt->setUInt32(1, WrongPassBanTime);
                    LoginDatabase.Execute(stmt);

                    LOG_DEBUG("network", "'%s:%d' [AuthChallenge] account %s got banned for '%u' seconds because it failed to authenticate '%u' times",
                        socket().getRemoteAddress().c_str(), socket().getRemotePort(), _accountInfo.Login.c_str(), WrongPassBanTime, _accountInfo.FailedLogins);
                }
                else
                {
                    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_IP_AUTO_BANNED);
                    stmt->setString(0, socket().getRemoteAddress());
                    stmt->setUInt32(1, WrongPassBanTime);
                    LoginDatabase.Execute(stmt);

                    LOG_DEBUG("network", "'%s:%d' [AuthChallenge] IP %s got banned for '%u' seconds because account %s failed to authenticate '%u' times",
                        socket().getRemoteAddress().c_str(), socket().getRemotePort(), socket().getRemoteAddress().c_str(), WrongPassBanTime, _accountInfo.Login.c_str(), _accountInfo.FailedLogins);
                }
            }
        }
    }

    return true;
}

// Reconnect Challenge command handler
bool AuthSocket::_HandleReconnectChallenge()
{
    LOG_TRACE("network", "Entering _HandleReconnectChallenge");

    if (socket().recv_len() < sizeof(sAuthLogonChallenge_C))
        return false;

    // Read the first 4 bytes (header) to get the length of the remaining of the packet
    std::vector<uint8> buf;
    buf.resize(4);

    socket().recv((char*)&buf[0], 4);

    EndianConvertPtr<uint16>(&buf[0]);

    uint16 remaining = ((sAuthLogonChallenge_C*)&buf[0])->size;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "[ReconnectChallenge] got header, body is %#04x bytes", remaining);
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
    LOG_DEBUG("network", "[ReconnectChallenge] got full packet, %#04x bytes", ch->size);
    LOG_DEBUG("network", "[ReconnectChallenge] name(%d): '%s'", ch->I_len, ch->I);
#endif

    std::string login((char const*)ch->I, ch->I_len);
    LOG_DEBUG("server.authserver", "[ReconnectChallenge] '%s'", login.c_str());

    // Reinitialize build, expansion and the account securitylevel
    _build = ch->build;
    _expversion = uint8(AuthHelper::IsPostBCAcceptedClientBuild(_build) ? POST_BC_EXP_FLAG : (AuthHelper::IsPreBCAcceptedClientBuild(_build) ? PRE_BC_EXP_FLAG : NO_VALID_EXP_FLAG));
    _os = (const char*)ch->os;

    if (_os.size() > 4)
        return false;

    auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_RECONNECTCHALLENGE);
    stmt->setString(0, login);

    PreparedQueryResult result = LoginDatabase.Query(stmt);

    // Stop if the account is not found
    if (!result)
    {
        LOG_ERROR("server", "'%s:%d' [ERROR] user %s tried to login and we cannot find his session key in the database.", socket().getRemoteAddress().c_str(), socket().getRemotePort(), login.c_str());
        socket().shutdown();
        return false;
    }

    Field* fields = result->Fetch();
    _accountInfo.LoadResult(fields);

    // Restore string order as its byte order is reversed
    std::reverse(_os.begin(), _os.end());

    _sessionKey = fields[9].GetBinary<SESSION_KEY_LENGTH>();
    Acore::Crypto::GetRandomBytes(_reconnectProof);

    ///- All good, await client's proof
    _status = STATUS_RECON_PROOF;

    // Sending response
    ByteBuffer pkt;
    pkt << uint8(AUTH_RECONNECT_CHALLENGE);
    pkt << uint8(WOW_SUCCESS);
    pkt.append(_reconnectProof);        // 16 bytes random
    pkt.append(VersionChallenge.data(), VersionChallenge.size());
    socket().send((char const*)pkt.contents(), pkt.size());
    return true;
}

// Reconnect Proof command handler
bool AuthSocket::_HandleReconnectProof()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Entering _HandleReconnectProof");
#endif
    // Read the packet
    sAuthReconnectProof_C lp;
    if (!socket().recv((char*)&lp, sizeof(sAuthReconnectProof_C)))
        return false;

    _status = STATUS_CLOSED;

    if (_accountInfo.Login.empty())
        return false;

    BigNumber t1;
    t1.SetBinary(lp.R1, 16);

    Acore::Crypto::SHA1 sha;
    sha.UpdateData(_accountInfo.Login);
    sha.UpdateData(t1.ToByteArray<16>());
    sha.UpdateData(_reconnectProof);
    sha.UpdateData(_sessionKey);
    sha.Finalize();

    if (sha.GetDigest() == lp.R2)
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
        LOG_ERROR("server.authserver.hack", "'%s:%d' [ERROR] user %s tried to login, but session is invalid.",
            socket().getRemoteAddress().c_str(), socket().getRemotePort(), _accountInfo.Login.c_str());
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
        if (realm.LocalAddress->is_loopback() || realm.ExternalAddress->is_loopback())
            return clientAddr;

        // Assume that user connecting from the machine that authserver is located on
        // has all realms available in his local network
        return *realm.LocalAddress;
    }

    // Check if connecting client is in the same network
    if (IsIPAddrInNetwork(*realm.LocalAddress, clientAddr, *realm.LocalSubnetMask))
    {
        return *realm.LocalAddress;
    }

    // Return external IP
    return *realm.ExternalAddress;
}

// Realm List command handler
bool AuthSocket::_HandleRealmList()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Entering _HandleRealmList");
#endif
    if (socket().recv_len() < 5)
        return false;

    socket().recv_skip(5);

    // Get the user id (else close the connection)
    // No SQL injection (prepared statement)
    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_ID_BY_NAME);
    stmt->setString(0, _accountInfo.Login);

    PreparedQueryResult result = LoginDatabase.Query(stmt);
    if (!result)
    {
        LOG_ERROR("server", "'%s:%d' [ERROR] user %s tried to login but we cannot find him in the database.", socket().getRemoteAddress().c_str(), socket().getRemotePort(), _accountInfo.Login.c_str());
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

    for (auto& [realmHandle, realm] : sRealmList->GetRealms())
    {
        // don't work with realms which not compatible with the client
        bool okBuild = ((_expversion & POST_BC_EXP_FLAG) && realm.Build == _build) || ((_expversion & PRE_BC_EXP_FLAG) && !AuthHelper::IsPreBCAcceptedClientBuild(realm.Build));

        // No SQL injection. id of realm is controlled by the database.
        uint32 flag = realm.Flags;

        RealmBuildInfo const* buildInfo = sRealmList->GetBuildInfo(realm.Build);
        if (!okBuild)
        {
            if (!buildInfo)
                continue;

            flag |= REALM_FLAG_OFFLINE | REALM_FLAG_SPECIFYBUILD;   // tell the client what build the realm is for
        }

        if (!buildInfo)
            flag &= ~REALM_FLAG_SPECIFYBUILD;

        std::string name = realm.Name;
        if (_expversion & PRE_BC_EXP_FLAG && flag & REALM_FLAG_SPECIFYBUILD)
        {
            std::ostringstream ss;
            ss << name << " (" << buildInfo->MajorVersion << '.' << buildInfo->MinorVersion << '.' << buildInfo->BugfixVersion << ')';
            name = ss.str();
        }

        // We don't need the port number from which client connects with but the realm's port
        clientAddr.set_port_number(realm.ExternalAddress->get_port_number());

        uint8 lock = (realm.AllowedSecurityLevel > _accountInfo.SecurityLevel) ? 1 : 0;

        uint8 AmountOfCharacters = 0;
        stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_NUM_CHARS_ON_REALM);
        stmt->setUInt32(0, realm.Id.Realm);
        stmt->setUInt32(1, id);
        result = LoginDatabase.Query(stmt);
        if (result)
            AmountOfCharacters = (*result)[0].GetUInt8();

        pkt << realm.Type;                                  // realm type
        if (_expversion & POST_BC_EXP_FLAG)                 // only 2.x and 3.x clients
            pkt << lock;                                    // if 1, then realm locked
        pkt << uint8(flag);                                 // RealmFlags
        pkt << name;
        pkt << GetAddressString(GetAddressForClient(realm, clientAddr));
        pkt << realm.PopulationLevel;
        pkt << AmountOfCharacters;
        pkt << realm.Timezone;                              // realm category
        if (_expversion & POST_BC_EXP_FLAG)                 // 2.x and 3.x clients
            pkt << uint8(realm.Id.Realm);
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
    LOG_DEBUG("network", "Entering _HandleXferResume");
#endif
    // Check packet length and patch existence
    if (socket().recv_len() < 9 || !pPatch) // FIXME: pPatch is never used
    {
        LOG_ERROR("server", "Error while resuming patch transfer (wrong packet)");
        return false;
    }

    // Launch a PatcherRunnable thread starting at given patch file offset
    uint64 start;
    socket().recv_skip(1);
    socket().recv((char*)&start, sizeof(start));
    fseek(pPatch, long(start), 0);

    Acore::Thread u(new PatcherRunnable(this));
    return true;
}

// Cancel patch transfer
bool AuthSocket::_HandleXferCancel()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Entering _HandleXferCancel");
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
    LOG_DEBUG("network", "Entering _HandleXferAccept");
#endif

    // Check packet length and patch existence
    if (!pPatch)
    {
        LOG_ERROR("server", "Error while accepting patch transfer (wrong packet)");
        return false;
    }

    // Launch a PatcherRunnable thread, starting at the beginning of the patch file
    socket().recv_skip(1);                                         // clear input buffer
    fseek(pPatch, 0, 0);

    Acore::Thread u(new PatcherRunnable(this));
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
#include <cerrno>
#include <dirent.h>
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
    LOG_DEBUG("network", "Loading patch info from %s\n", path.c_str());
#endif

    if (!pPatch)
    {
        LOG_ERROR("server", "Error loading patch %s\n", path.c_str());
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

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AccountMgr.h"
#include "BanManager.h"
#include "ByteBuffer.h"
#include "Common.h"
#include "Log.h"
#include "Opcodes.h"
#include "Player.h"
#include "SharedDefines.h"
#include "Util.h"
#include "Warden.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include <openssl/sha.h>

Warden::Warden() : _session(nullptr), _checkTimer(10000/*10 sec*/), _clientResponseTimer(0),
    _dataSent(false), _module(nullptr), _initialized(false)
{
    memset(_inputKey, 0, sizeof(_inputKey));
    memset(_outputKey, 0, sizeof(_outputKey));
    memset(_seed, 0, sizeof(_seed));
}

Warden::~Warden()
{
    delete[] _module->CompressedData;
    delete _module;
    _module = nullptr;
    _initialized = false;
}

void Warden::SendModuleToClient()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("warden", "Send module to client");
#endif

    // Create packet structure
    WardenModuleTransfer packet;

    uint32 sizeLeft = _module->CompressedSize;
    uint32 pos = 0;
    uint16 burstSize;
    while (sizeLeft > 0)
    {
        burstSize = sizeLeft < 500 ? sizeLeft : 500;
        packet.Command = WARDEN_SMSG_MODULE_CACHE;
        packet.DataSize = burstSize;
        memcpy(packet.Data, &_module->CompressedData[pos], burstSize);
        sizeLeft -= burstSize;
        pos += burstSize;

        EncryptData((uint8*)&packet, burstSize + 3);
        WorldPacket pkt1(SMSG_WARDEN_DATA, burstSize + 3);
        pkt1.append((uint8*)&packet, burstSize + 3);
        _session->SendPacket(&pkt1);
    }
}

void Warden::RequestModule()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("warden", "Request module");
#endif

    // Create packet structure
    WardenModuleUse request;
    request.Command = WARDEN_SMSG_MODULE_USE;

    memcpy(request.ModuleId, _module->Id, 16);
    memcpy(request.ModuleKey, _module->Key, 16);
    request.Size = _module->CompressedSize;

    EndianConvert(request.Size);

    // Encrypt with warden RC4 key.
    EncryptData((uint8*)&request, sizeof(WardenModuleUse));

    WorldPacket pkt(SMSG_WARDEN_DATA, sizeof(WardenModuleUse));
    pkt.append((uint8*)&request, sizeof(WardenModuleUse));
    _session->SendPacket(&pkt);
}

void Warden::Update(uint32 const diff)
{
    if (!_initialized)
    {
        return;
    }

    if (_dataSent)
    {
        uint32 maxClientResponseDelay = sWorld->getIntConfig(CONFIG_WARDEN_CLIENT_RESPONSE_DELAY);
        if (maxClientResponseDelay > 0)
        {
            if (_clientResponseTimer > maxClientResponseDelay * IN_MILLISECONDS)
            {
                _session->KickPlayer("Warden: clientResponseTimer > maxClientResponseDelay (Warden::Update)");
            }
            else
            {
                _clientResponseTimer += diff;
            }
        }
    }
    else
    {
        if (diff >= _checkTimer)
        {
            RequestChecks();
        }
        else
        {
            _checkTimer -= diff;
        }
    }
}

void Warden::DecryptData(uint8* buffer, uint32 length)
{
    _inputCrypto.UpdateData(buffer, length);
}

void Warden::EncryptData(uint8* buffer, uint32 length)
{
    _outputCrypto.UpdateData(buffer, length);
}

bool Warden::IsValidCheckSum(uint32 checksum, const uint8* data, const uint16 length)
{
    uint32 newChecksum = BuildChecksum(data, length);

    if (checksum != newChecksum)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("warden", "CHECKSUM IS NOT VALID");
#endif
        return false;
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("warden", "CHECKSUM IS VALID");
#endif
        return true;
    }
}

struct keyData
{
    union
    {
        struct
        {
            uint8 bytes[20];
        } bytes;

        struct
        {
            uint32 ints[5];
        } ints;
    };
};

uint32 Warden::BuildChecksum(const uint8* data, uint32 length)
{
    keyData hash;
    SHA1(data, length, hash.bytes.bytes);
    uint32 checkSum = 0;
    for (uint8 i = 0; i < 5; ++i)
    {
        checkSum = checkSum ^ hash.ints.ints[i];
    }

    return checkSum;
}

static std::string GetWardenActionStr(uint32 action)
{
    switch (action)
    {
    case WARDEN_ACTION_LOG:
        return "WARDEN_ACTION_LOG";
    case WARDEN_ACTION_KICK:
        return "WARDEN_ACTION_KICK";
    case WARDEN_ACTION_BAN:
        return "WARDEN_ACTION_BAN";
    }

    return "UNHANDLED ACTION";
}

void Warden::ApplyPenalty(uint16 checkId, std::string const& reason)
{
    WardenCheck const* checkData = sWardenCheckMgr->GetWardenDataById(checkId);

    uint32 action = WardenActions(sWorld->getIntConfig(CONFIG_WARDEN_CLIENT_FAIL_ACTION));
    std::string causeMsg;
    if (checkId && checkData)
    {
        action = checkData->Action;

        if (checkData->Comment.empty())
        {
            causeMsg = "Warden id " + std::to_string(checkId) + " violation";
        }
        else
        {
            causeMsg = "Warden: " + checkData->Comment;
        }
    }
    else
    {
        // if its not warden check id based, reason must be always provided
        ASSERT(!reason.empty());
        causeMsg = reason;
    }

    switch (action)
    {
        case WARDEN_ACTION_LOG:
            break;
        case WARDEN_ACTION_KICK:
        {
            _session->KickPlayer(causeMsg.find("Warden") != std::string::npos ? causeMsg : "Warden: " + causeMsg);
            break;
        }
        case WARDEN_ACTION_BAN:
        {
            std::stringstream duration;
            duration << sWorld->getIntConfig(CONFIG_WARDEN_CLIENT_BAN_DURATION) << "s";
            std::string accountName;
            AccountMgr::GetName(_session->GetAccountId(), accountName);
            sBan->BanAccount(accountName, duration.str(), causeMsg, "Server");
            break;
        }
    }

    std::string reportMsg;
    if (checkId)
    {
        if (Player const* plr = _session->GetPlayer())
        {
            std::string const reportFormat = "Player %s (guid %u, account id: %u) failed warden %u check (%s). Action: %s";
            reportMsg = Acore::StringFormat(reportFormat, plr->GetName().c_str(), plr->GetGUID().GetCounter(), _session->GetAccountId(),
                                           checkId, ((checkData && !checkData->Comment.empty()) ? checkData->Comment.c_str() : "<warden comment is not set>"),
                                           GetWardenActionStr(action).c_str());
        }
        else
        {
            std::string const reportFormat = "Account id: %u failed warden %u check. Action: %s";
            reportMsg = Acore::StringFormat(reportFormat, _session->GetAccountId(), checkId, GetWardenActionStr(action).c_str());
        }
    }
    else
    {
        if (Player const* plr = _session->GetPlayer())
        {
            std::string const reportFormat = "Player %s (guid %u, account id: %u) triggered warden penalty by reason: %s. Action: %s";
            reportMsg = Acore::StringFormat(reportFormat, plr->GetName().c_str(), plr->GetGUID().GetCounter(), _session->GetAccountId(), causeMsg.c_str(), GetWardenActionStr(action).c_str());
        }
        else
        {
            std::string const reportFormat = "Account id: %u failed warden %u check. Action: %s";
            reportMsg = Acore::StringFormat(reportFormat, _session->GetAccountId(), causeMsg.c_str(), GetWardenActionStr(action).c_str());
        }
    }

    reportMsg = "Warden: " + reportMsg;
    LOG_INFO("warden", "> Warden: %s", reportMsg.c_str());
}

bool Warden::ProcessLuaCheckResponse(std::string const& msg)
{
    static constexpr char WARDEN_TOKEN[] = "_TW\t";
    // if msg starts with WARDEN_TOKEN
    if (msg.rfind(WARDEN_TOKEN, 0) != 0)
    {
        return false;
    }

    uint16 id = 0;

    {
        std::stringstream msg2(msg);
        std::string temp;
        while (msg2 >> temp)
        {
            // Found check id - stop loop
            if (std::stringstream(temp) >> id)
                break;
        }
    }

    if (id < sWardenCheckMgr->GetMaxValidCheckId())
    {
        WardenCheck const* check = sWardenCheckMgr->GetWardenDataById(id);
        if (check && check->Type == LUA_EVAL_CHECK)
        {
            ApplyPenalty(id, "");
            return true;
        }
    }

    ApplyPenalty(0, "Sent bogus Lua check response for Warden");
    return true;
}

void WorldSession::HandleWardenDataOpcode(WorldPacket& recvData)
{
    if (!_warden || recvData.empty())
        return;

    _warden->DecryptData(recvData.contents(), recvData.size());
    uint8 opcode;
    recvData >> opcode;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("warden", "Got packet, opcode %02X, size %u", opcode, uint32(recvData.size()));
#endif
    recvData.hexlike();

    switch (opcode)
    {
        case WARDEN_CMSG_MODULE_MISSING:
            _warden->SendModuleToClient();
            break;
        case WARDEN_CMSG_MODULE_OK:
            _warden->RequestHash();
            break;
        case WARDEN_CMSG_CHEAT_CHECKS_RESULT:
            _warden->HandleData(recvData);
            break;
        case WARDEN_CMSG_MEM_CHECKS_RESULT:
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            LOG_DEBUG("warden", "NYI WARDEN_CMSG_MEM_CHECKS_RESULT received!");
#endif
            break;
        case WARDEN_CMSG_HASH_RESULT:
            _warden->HandleHashResult(recvData);
            _warden->InitializeModule();
            break;
        case WARDEN_CMSG_MODULE_FAILED:
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            LOG_DEBUG("warden", "NYI WARDEN_CMSG_MODULE_FAILED received!");
#endif
            break;
        default:
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            LOG_DEBUG("warden", "Got unknown warden opcode %02X of size %u.", opcode, uint32(recvData.size() - 1));
#endif
            break;
    }
}

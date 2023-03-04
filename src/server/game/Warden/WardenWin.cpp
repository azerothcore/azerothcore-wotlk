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

#include "WardenWin.h"
#include "ByteBuffer.h"
#include "Common.h"
#include "CryptoRandom.h"
#include "GameTime.h"
#include "HMAC.h"
#include "Log.h"
#include "Opcodes.h"
#include "Player.h"
#include "SessionKeyGenerator.h"
#include "Util.h"
#include "WardenCheckMgr.h"
#include "WardenModuleWin.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

// GUILD is the shortest string that has no client validation (RAID only sends if in a raid group)
static constexpr char _luaEvalPrefix[] = "local S,T,R=SendAddonMessage,function()";
static constexpr char _luaEvalMidfix[] = " end R=S and T()if R then S('_TW',";
static constexpr char _luaEvalPostfix[] = ",'GUILD')end";

static_assert((sizeof(_luaEvalPrefix)-1 + sizeof(_luaEvalMidfix)-1 + sizeof(_luaEvalPostfix)-1 + WARDEN_MAX_LUA_CHECK_LENGTH) == 255);

static constexpr uint8 GetCheckPacketBaseSize(uint8 type)
{
    switch (type)
    {
    case DRIVER_CHECK:
    case MPQ_CHECK: return 1;
    case LUA_EVAL_CHECK: return 1 + sizeof(_luaEvalPrefix) - 1 + sizeof(_luaEvalMidfix) - 1 + 4 + sizeof(_luaEvalPostfix) - 1;
    case PAGE_CHECK_A: return (4 + 1);
    case PAGE_CHECK_B: return (4 + 1);
    case MODULE_CHECK: return (4 + Acore::Crypto::Constants::SHA1_DIGEST_LENGTH_BYTES);
    case MEM_CHECK: return (1 + 4 + 1);
    default: return 0;
    }
}

static uint16 GetCheckPacketSize(WardenCheck const* check)
{
    if (!check)
    {
        return 0;
    }

    uint16 size = 1;

    if (check->CheckId >= WardenPayloadMgr::WardenPayloadOffsetMin && check->Type == LUA_EVAL_CHECK)
    {
        // Custom payload has no prefix, midfix, postfix.
        size = size + (4 + 1);
    }
    else
    {
        size = size + GetCheckPacketBaseSize(check->Type);  // 1 byte check type
    }

    if (!check->Str.empty())
    {
        size += (static_cast<uint16>(check->Str.length()) + 1); // 1 byte string length
    }

    BigNumber tempNumber = check->Data;
    if (!tempNumber.GetNumBytes())
    {
        size += tempNumber.GetNumBytes();
    }
    return size;
}

// Returns config id for specific type id
static WorldIntConfigs GetMaxWardenChecksForType(uint8 type)
{
    // Should never be higher type than defined
    ASSERT(type < MAX_WARDEN_CHECK_TYPES);

    switch (type)
    {
    case WARDEN_CHECK_MEM_TYPE:
        return CONFIG_WARDEN_NUM_MEM_CHECKS;
    case WARDEN_CHECK_LUA_TYPE:
        return CONFIG_WARDEN_NUM_LUA_CHECKS;
    default:
        break;
    }

    return CONFIG_WARDEN_NUM_OTHER_CHECKS;
}

WardenWin::WardenWin() : Warden(), _serverTicks(0) { }

WardenWin::~WardenWin() = default;

void WardenWin::Init(WorldSession* session, SessionKey const& k)
{
    _session = session;
    // Generate Warden Key
    SessionKeyGenerator<Acore::Crypto::SHA1> WK(k);
    WK.Generate(_inputKey, 16);
    WK.Generate(_outputKey, 16);

    memcpy(_seed, Module.Seed, 16);

    _inputCrypto.Init(_inputKey);
    _outputCrypto.Init(_outputKey);
    LOG_DEBUG("warden", "Server side warden for client {} initializing...", session->GetAccountId());
    LOG_DEBUG("warden", "C->S Key: {}", Acore::Impl::ByteArrayToHexStr(_inputKey, 16));
    LOG_DEBUG("warden", "S->C Key: {}", Acore::Impl::ByteArrayToHexStr(_outputKey,16));
    LOG_DEBUG("warden", "  Seed: {}", Acore::Impl::ByteArrayToHexStr(_seed, 16));
    LOG_DEBUG("warden", "Loading Module...");

    _module = GetModuleForClient();

    LOG_DEBUG("warden", "Module Key: {}", ByteArrayToHexStr(_module->Key));
    LOG_DEBUG("warden", "Module ID: {}", ByteArrayToHexStr(_module->Id));
    RequestModule();
}

ClientWardenModule* WardenWin::GetModuleForClient()
{
    auto mod = new ClientWardenModule;

    uint32 length = sizeof(Module.Module);

    // data assign
    mod->CompressedSize = length;
    mod->CompressedData = new uint8[length];
    memcpy(mod->CompressedData, Module.Module, length);
    memcpy(mod->Key.data(), Module.ModuleKey, 16);

    // md5 hash
    mod->Id = Acore::Crypto::MD5::GetDigestOf(mod->CompressedData, mod->CompressedSize);

    return mod;
}

void WardenWin::InitializeModule()
{
    LOG_DEBUG("warden", "Initialize module");

    // Create packet structure
    WardenInitModuleRequest Request{};
    Request.Command1 = WARDEN_SMSG_MODULE_INITIALIZE;
    Request.Size1 = 20;
    Request.Unk1 = 1;
    Request.Unk2 = 0;
    Request.Type = 1;
    Request.String_library1 = 0;
    Request.Function1[0] = 0x00024F80;                      // 0x00400000 + 0x00024F80 SFileOpenFile
    Request.Function1[1] = 0x000218C0;                      // 0x00400000 + 0x000218C0 SFileGetFileSize
    Request.Function1[2] = 0x00022530;                      // 0x00400000 + 0x00022530 SFileReadFile
    Request.Function1[3] = 0x00022910;                      // 0x00400000 + 0x00022910 SFileCloseFile
    Request.CheckSumm1 = BuildChecksum(&Request.Unk1, Acore::Crypto::Constants::SHA1_DIGEST_LENGTH_BYTES);

    Request.Command2 = WARDEN_SMSG_MODULE_INITIALIZE;
    Request.Size2 = 8;
    Request.Unk3 = 4;
    Request.Unk4 = 0;
    Request.String_library2 = 0;
    Request.Function2 = 0x00419210;                         // 0x00400000 + 0x00419210 FrameScript::Execute
    Request.Function2_set = 1;
    Request.CheckSumm2 = BuildChecksum(&Request.Unk3, 8);

    Request.Command3 = WARDEN_SMSG_MODULE_INITIALIZE;
    Request.Size3 = 8;
    Request.Unk5 = 1;
    Request.Unk6 = 1;
    Request.String_library3 = 0;
    Request.Function3 = 0x0046AE20;                         // 0x00400000 + 0x0046AE20 PerformanceCounter
    Request.Function3_set = 1;
    Request.CheckSumm3 = BuildChecksum(&Request.Unk5, 8);

    EndianConvert(Request.Size1);
    EndianConvert(Request.CheckSumm1);
    EndianConvert(Request.Function1[0]);
    EndianConvert(Request.Function1[1]);
    EndianConvert(Request.Function1[2]);
    EndianConvert(Request.Function1[3]);
    EndianConvert(Request.Size2);
    EndianConvert(Request.CheckSumm2);
    EndianConvert(Request.Function2);
    EndianConvert(Request.Size3);
    EndianConvert(Request.CheckSumm3);
    EndianConvert(Request.Function3);

    // Encrypt with warden RC4 key.
    EncryptData(reinterpret_cast<uint8*>(&Request), sizeof(WardenInitModuleRequest));

    WorldPacket pkt(SMSG_WARDEN_DATA, sizeof(WardenInitModuleRequest));
    pkt.append(reinterpret_cast<uint8*>(&Request), sizeof(WardenInitModuleRequest));
    _session->SendPacket(&pkt);
}

void WardenWin::RequestHash()
{
    LOG_DEBUG("warden", "Request hash");

    // Create packet structure
    WardenHashRequest Request{};
    Request.Command = WARDEN_SMSG_HASH_REQUEST;
    memcpy(Request.Seed, _seed, 16);

    // Encrypt with warden RC4 key.
    EncryptData(reinterpret_cast<uint8*>(&Request), sizeof(WardenHashRequest));

    WorldPacket pkt(SMSG_WARDEN_DATA, sizeof(WardenHashRequest));
    pkt.append(reinterpret_cast<uint8*>(&Request), sizeof(WardenHashRequest));
    _session->SendPacket(&pkt);
}

void WardenWin::HandleHashResult(ByteBuffer& buff)
{
    buff.rpos(buff.wpos());

    // Verify key
    if (memcmp(buff.contents() + 1, Module.ClientKeySeedHash, Acore::Crypto::Constants::SHA1_DIGEST_LENGTH_BYTES) != 0)
    {
        LOG_DEBUG("warden", "Request hash reply: failed");
        ApplyPenalty(0, "Request hash reply: failed");
        return;
    }

    LOG_DEBUG("warden", "Request hash reply: succeed");

    // Change keys here
    memcpy(_inputKey, Module.ClientKeySeed, 16);
    memcpy(_outputKey, Module.ServerKeySeed, 16);

    _inputCrypto.Init(_inputKey);
    _outputCrypto.Init(_outputKey);

    _initialized = true;
}

/**
* @brief Gets the warden check state.
* @return The warden check state.
*/
bool WardenWin::IsCheckInProgress()
{
    return _checkInProgress;
}

/**
* @brief Force call RequestChecks() so they are sent immediately, this interrupts warden and breaks result.
*/
void WardenWin::ForceChecks()
{
    if (_dataSent)
    {
        _interrupted = true;
        _interruptCounter++;
    }

    RequestChecks();
}

void WardenWin::RequestChecks()
{
    LOG_DEBUG("warden", "Request data");

    _checkInProgress = true;

    // If all checks were done, fill the todo list again
    for (uint8 i = 0; i < MAX_WARDEN_CHECK_TYPES; ++i)
    {
        if (_ChecksTodo[i].empty())
            _ChecksTodo[i].assign(sWardenCheckMgr->CheckIdPool[i].begin(), sWardenCheckMgr->CheckIdPool[i].end());
    }

    _serverTicks = GameTime::GetGameTimeMS().count();
    _CurrentChecks.clear();

    // Erase any nullptrs.
    Acore::Containers::EraseIf(_PendingChecks,
        [this](uint16 id)
        {
            WardenCheck const* check = sWardenCheckMgr->GetWardenDataById(id);

            // Custom payload should be loaded in if equal to over offset.
            if (!check && id >= WardenPayloadMgr::WardenPayloadOffsetMin)
            {
                if (_payloadMgr.CachedChecks.find(id) != _payloadMgr.CachedChecks.end())
                {
                    check = &_payloadMgr.CachedChecks.at(id);
                }
            }

            if (!check)
            {
                return true;
            }

            return false;
        }
    );

    // No pending checks
    if (_PendingChecks.empty())
    {
        for (uint8 checkType = 0; checkType < MAX_WARDEN_CHECK_TYPES; ++checkType)
        {
            for (uint32 y = 0; y < sWorld->getIntConfig(GetMaxWardenChecksForType(checkType)); ++y)
            {
                // If todo list is done break loop (will be filled on next Update() run)
                if (_ChecksTodo[checkType].empty())
                {
                    break;
                }

                // Load in any custom payloads if available.
                if (checkType == WARDEN_CHECK_LUA_TYPE && !_payloadMgr.QueuedPayloads.empty())
                {
                    uint16 payloadId = _payloadMgr.QueuedPayloads.front();

                    LOG_DEBUG("warden", "Adding custom warden payload '{}' to CurrentChecks.", payloadId);

                    _payloadMgr.QueuedPayloads.pop_front();
                    _CurrentChecks.push_front(payloadId);

                    continue;
                }

                // Get check id from the end and remove it from todo
                uint16 const id = _ChecksTodo[checkType].back();
                _ChecksTodo[checkType].pop_back();

                // Insert check to queue
                if (checkType == WARDEN_CHECK_LUA_TYPE)
                {
                    _CurrentChecks.push_front(id);
                }
                else
                {
                    _CurrentChecks.push_back(id);
                }
            }
        }
    }
    else
    {
        bool hasLuaChecks = false;
        for (uint16 const checkId : _PendingChecks)
        {
            WardenCheck const* check = sWardenCheckMgr->GetWardenDataById(checkId);

            // Custom payload should be loaded in if equal to over offset.
            if (!check && checkId >= WardenPayloadMgr::WardenPayloadOffsetMin)
            {
                check = &_payloadMgr.CachedChecks.at(checkId);
            }

            if (!hasLuaChecks && check->Type == LUA_EVAL_CHECK)
            {
                hasLuaChecks = true;
            }

            _CurrentChecks.push_back(checkId);
        }

        // Always include lua checks
        if (!hasLuaChecks)
        {
            for (uint32 i = 0; i < sWorld->getIntConfig(GetMaxWardenChecksForType(WARDEN_CHECK_LUA_TYPE)); ++i)
            {
                // If todo list is done break loop (will be filled on next Update() run)
                if (_ChecksTodo[WARDEN_CHECK_LUA_TYPE].empty())
                {
                    break;
                }

                // Get check id from the end and remove it from todo
                uint16 const id = _ChecksTodo[WARDEN_CHECK_LUA_TYPE].back();
                _ChecksTodo[WARDEN_CHECK_LUA_TYPE].pop_back();

                // Lua checks must be always in front
                _CurrentChecks.push_front(id);
            }
        }
    }

    // Filter too high checks queue
    // Filtered checks will get passed in next checks
    uint16 expectedSize = 4;
    _PendingChecks.clear();
    Acore::Containers::EraseIf(_CurrentChecks,
        [this, &expectedSize](uint16 id)
        {
            WardenCheck const* check = sWardenCheckMgr->GetWardenDataById(id);

            // Custom payload should be loaded in if equal to over offset.
            if (!check && id >= WardenPayloadMgr::WardenPayloadOffsetMin)
            {
                check = &_payloadMgr.CachedChecks.at(id);
            }

            // Remove nullptr if it snuck in from earlier check.
            if (!check)
            {
                return true;
            }

            uint16 const thisSize = GetCheckPacketSize(check);
            if ((expectedSize + thisSize) > 500) // warden packets are truncated to 512 bytes clientside
            {
                _PendingChecks.push_back(id);
                return true;
            }
            expectedSize += thisSize;
            return false;
        }
    );

    ByteBuffer buff;
    buff << uint8(WARDEN_SMSG_CHEAT_CHECKS_REQUEST);

    for (uint16 const checkId : _CurrentChecks)
    {
        WardenCheck const* check = sWardenCheckMgr->GetWardenDataById(checkId);

        // Custom payloads do not have prefix, midfix, postfix.
        if (!check && checkId >= WardenPayloadMgr::WardenPayloadOffsetMin)
        {
            check = &_payloadMgr.CachedChecks.at(checkId);

            buff << uint8(check->Str.size());
            buff.append(check->Str.data(), check->Str.size());

            continue;
        }

        switch (check->Type)
        {
            case LUA_EVAL_CHECK:
            {
                buff << uint8(sizeof(_luaEvalPrefix) - 1 + check->Str.size() + sizeof(_luaEvalMidfix) - 1 + check->IdStr.size() + sizeof(_luaEvalPostfix) - 1);
                buff.append(_luaEvalPrefix, sizeof(_luaEvalPrefix) - 1);
                buff.append(check->Str.data(), check->Str.size());
                buff.append(_luaEvalMidfix, sizeof(_luaEvalMidfix) - 1);
                buff.append(check->IdStr.data(), check->IdStr.size());
                buff.append(_luaEvalPostfix, sizeof(_luaEvalPostfix) - 1);
                break;
            }
            case MPQ_CHECK:
            case DRIVER_CHECK:
            {
                buff << uint8(check->Str.size());
                buff.append(check->Str.c_str(), check->Str.size());
                break;
            }
        }
    }

    uint8 const xorByte = _inputKey[0];

    // Add TIMING_CHECK
    buff << uint8(0x00);
    buff << uint8(TIMING_CHECK ^ xorByte);

    uint8 index = 1;

    for (uint16 const checkId : _CurrentChecks)
    {
        WardenCheck const* check = sWardenCheckMgr->GetWardenDataById(checkId);

        // Custom payload should be loaded in if equal to over offset.
        if (!check && checkId >= WardenPayloadMgr::WardenPayloadOffsetMin)
        {
            check = &_payloadMgr.CachedChecks.at(checkId);
        }

        buff << uint8(check->Type ^ xorByte);
        switch (check->Type)
        {
            case MEM_CHECK:
            {
                buff << uint8(0x00);
                buff << uint32(check->Address);
                buff << uint8(check->Length);
                break;
            }
            case PAGE_CHECK_A:
            case PAGE_CHECK_B:
            {
                std::vector<uint8> data = check->Data.ToByteVector(24, false);
                buff.append(data.data(), data.size());
                buff << uint32(check->Address);
                buff << uint8(check->Length);
                break;
            }
            case MPQ_CHECK:
            case LUA_EVAL_CHECK:
            {
                buff << uint8(index++);
                break;
            }
            case DRIVER_CHECK:
            {
                std::vector<uint8> data = check->Data.ToByteVector(24, false);
                buff.append(data.data(), data.size());
                buff << uint8(index++);
                break;
            }
            case MODULE_CHECK:
            {
                std::array<uint8, 4> seed = Acore::Crypto::GetRandomBytes<4>();
                buff.append(seed);
                buff.append(Acore::Crypto::HMAC_SHA1::GetDigestOf(seed, check->Str));
                break;
            }
            /*case PROC_CHECK:
            {
                buff.append(wd->i.AsByteArray(0, false).get(), wd->i.GetNumBytes());
                buff << uint8(index++);
                buff << uint8(index++);
                buff << uint32(wd->Address);
                buff << uint8(wd->Length);
                break;
            }*/
        }
    }
    buff << uint8(xorByte);
    buff.hexlike();

    // Encrypt with warden RC4 key
    EncryptData(buff.contents(), buff.size());

    WorldPacket pkt(SMSG_WARDEN_DATA, buff.size());
    pkt.append(buff);
    _session->SendPacket(&pkt);

    _dataSent = true;

    std::stringstream stream;
    stream << "Sent check id's: ";
    for (uint16 checkId : _CurrentChecks)
    {
        stream << checkId << " ";
    }

    LOG_DEBUG("warden", "{}", stream.str());
}

void WardenWin::HandleData(ByteBuffer& buff)
{
    LOG_DEBUG("warden", "Handle data");

    _dataSent = false;
    _clientResponseTimer = 0;

    uint16 Length;
    buff >> Length;
    uint32 Checksum;
    buff >> Checksum;

    if (Length != (buff.size() - buff.rpos()))
    {
        buff.rfinish();

        if (!_interrupted)
        {
            ApplyPenalty(0, "Failed size checks in HandleData");
        }

        return;
    }

    if (!IsValidCheckSum(Checksum, buff.contents() + buff.rpos(), Length))
    {
        buff.rpos(buff.wpos());
        LOG_DEBUG("warden", "CHECKSUM FAIL");

        if (!_interrupted)
        {
            ApplyPenalty(0, "Failed checksum in HandleData");
        }

        return;
    }

    // TIMING_CHECK
    {
        uint8 result;
        buff >> result;
        /// @todo: test it.
        if (result == 0x00)
        {
            LOG_DEBUG("warden", "TIMING CHECK FAIL result 0x00");
            // ApplyPenalty(0, "TIMING CHECK FAIL result"); Commented out because of too many false postives. Mostly caused by client stutter.
            return;
        }

        uint32 newClientTicks;
        buff >> newClientTicks;

        uint32 ticksNow = GameTime::GetGameTimeMS().count();
        uint32 ourTicks = newClientTicks + (ticksNow - _serverTicks);

        LOG_DEBUG("warden", "ServerTicks {}", ticksNow);         // Now
        LOG_DEBUG("warden", "RequestTicks {}", _serverTicks);    // At request
        LOG_DEBUG("warden", "Ticks {}", newClientTicks);         // At response
        LOG_DEBUG("warden", "Ticks diff {}", ourTicks - newClientTicks);
    }

    uint16 checkFailed = 0;

    for (uint16 const checkId : _CurrentChecks)
    {
        WardenCheck const* rd = sWardenCheckMgr->GetWardenDataById(checkId);

        // Custom payload should be loaded in if equal to over offset.
        if (!rd && checkId >= WardenPayloadMgr::WardenPayloadOffsetMin)
        {
            rd = &_payloadMgr.CachedChecks.at(checkId);
        }

        uint8 const type = rd->Type;
        switch (type)
        {
        case MEM_CHECK:
        {
            uint8 Mem_Result;
            buff >> Mem_Result;

            if (Mem_Result != 0)
            {
                LOG_DEBUG("warden", "RESULT MEM_CHECK not 0x00, CheckId {} account Id {}", checkId, _session->GetAccountId());
                checkFailed = checkId;
                continue;
            }

            WardenCheckResult const* rs = sWardenCheckMgr->GetWardenResultById(checkId);

            std::vector<uint8> result = rs->Result.ToByteVector(0, false);
            if (memcmp(buff.contents() + buff.rpos(), result.data(), rd->Length) != 0)
            {
                LOG_DEBUG("warden", "RESULT MEM_CHECK fail CheckId {} account Id {}", checkId, _session->GetAccountId());
                checkFailed = checkId;
                buff.rpos(buff.rpos() + rd->Length);
                continue;
            }

            buff.rpos(buff.rpos() + rd->Length);
            LOG_DEBUG("warden", "RESULT MEM_CHECK passed CheckId {} account Id {}", checkId, _session->GetAccountId());
            break;
        }
        case PAGE_CHECK_A:
        case PAGE_CHECK_B:
        case DRIVER_CHECK:
        case MODULE_CHECK:
        {
            uint8 const byte = 0xE9;
            if (memcmp(buff.contents() + buff.rpos(), &byte, sizeof(uint8)) != 0)
            {
                if (type == PAGE_CHECK_A || type == PAGE_CHECK_B)
                {
                    LOG_DEBUG("warden", "RESULT PAGE_CHECK fail, CheckId {} account Id {}", checkId, _session->GetAccountId());
                }

                if (type == MODULE_CHECK)
                {
                    LOG_DEBUG("warden", "RESULT MODULE_CHECK fail, CheckId {} account Id {}", checkId, _session->GetAccountId());
                }

                if (type == DRIVER_CHECK)
                {
                    LOG_DEBUG("warden", "RESULT DRIVER_CHECK fail, CheckId {} account Id {}", checkId, _session->GetAccountId());
                }

                checkFailed = checkId;
                buff.rpos(buff.rpos() + 1);
                continue;
            }

            buff.rpos(buff.rpos() + 1);

            if (type == PAGE_CHECK_A || type == PAGE_CHECK_B)
            {
                LOG_DEBUG("warden", "RESULT PAGE_CHECK passed CheckId {} account Id {}", checkId, _session->GetAccountId());
            }
            else if (type == MODULE_CHECK)
            {
                LOG_DEBUG("warden", "RESULT MODULE_CHECK passed CheckId {} account Id {}", checkId, _session->GetAccountId());
            }
            else if (type == DRIVER_CHECK)
            {
                LOG_DEBUG("warden", "RESULT DRIVER_CHECK passed CheckId {} account Id {}", checkId, _session->GetAccountId());
            }
            break;
        }
        case LUA_EVAL_CHECK:
        {
            uint8 const result = buff.read<uint8>();

            if (result == 0)
            {
                buff.read_skip(buff.read<uint8>()); // discard attached string
            }

            LOG_DEBUG("warden", "LUA_EVAL_CHECK CheckId {} account Id {} got in-warden dummy response", checkId, _session->GetAccountId()/* , result */);
            break;
        }
        case MPQ_CHECK:
        {
            uint8 Mpq_Result;
            buff >> Mpq_Result;

            if (Mpq_Result != 0)
            {
                LOG_DEBUG("warden", "RESULT MPQ_CHECK not 0x00 account id {}", _session->GetAccountId());
                checkFailed = checkId;
                continue;
            }

            WardenCheckResult const* rs = sWardenCheckMgr->GetWardenResultById(checkId);
            if (memcmp(buff.contents() + buff.rpos(), rs->Result.ToByteArray<20>(false).data(), Acore::Crypto::Constants::SHA1_DIGEST_LENGTH_BYTES) != 0) // SHA1
            {
                LOG_DEBUG("warden", "RESULT MPQ_CHECK fail, CheckId {} account Id {}", checkId, _session->GetAccountId());
                checkFailed = checkId;
                buff.rpos(buff.rpos() + Acore::Crypto::Constants::SHA1_DIGEST_LENGTH_BYTES);            // 20 bytes SHA1
                continue;
            }

            buff.rpos(buff.rpos() + Acore::Crypto::Constants::SHA1_DIGEST_LENGTH_BYTES);                // 20 bytes SHA1
            LOG_DEBUG("warden", "RESULT MPQ_CHECK passed, CheckId {} account Id {}", checkId, _session->GetAccountId());
            break;
        }
        }
    }

    if (checkFailed > 0 && !_interrupted)
    {
        ApplyPenalty(checkFailed, "");
    }

    if (_interrupted)
    {
        LOG_DEBUG("warden", "Warden was interrupted by ForceChecks, ignoring results.");

        _interruptCounter--;

        if (_interruptCounter == 0)
        {
            _interrupted = false;
        }
    }

    // Set hold off timer, minimum timer should at least be 1 second
    uint32 const holdOff = sWorld->getIntConfig(CONFIG_WARDEN_CLIENT_CHECK_HOLDOFF);
    _checkTimer = (holdOff < 1 ? 1 : holdOff) * IN_MILLISECONDS;

    _checkInProgress = false;
}

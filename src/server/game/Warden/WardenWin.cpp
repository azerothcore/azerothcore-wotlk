/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Cryptography/HMACSHA1.h"
#include "Cryptography/WardenKeyGeneration.h"
#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Log.h"
#include "Opcodes.h"
#include "ByteBuffer.h"
#include <openssl/md5.h>
#include "Database/DatabaseEnv.h"
#include "World.h"
#include "Player.h"
#include "Util.h"
#include "WardenWin.h"
#include "WardenModuleWin.h"
#include "WardenCheckMgr.h"
#include "AccountMgr.h"

WardenWin::WardenWin() : Warden(), _serverTicks(0) { }

WardenWin::~WardenWin()
{
    // Xinef: ZOMG! CRASH DEBUG INFO
    uint32 otherSize = _otherChecksTodo.size();
    uint32 memSize = _memChecksTodo.size();
    uint32 curSize = _currentChecks.size();
    bool otherClear = _otherChecksTodo.empty();
    bool memClear = _memChecksTodo.empty();
    bool curClear = _currentChecks.empty();

    sLog->outDebug(LOG_FILTER_POOLSYS, "IM DESTRUCTING MYSELF QQ, OTHERSIZE: %u, OTHEREM: %u, MEMSIZE: %u, MEMEM: %u, CURSIZE: %u, CUREM: %u!\n", otherSize, otherClear, memSize, memClear, curSize, curClear);
    _otherChecksTodo.clear();
    _memChecksTodo.clear();
    _currentChecks.clear();
    sLog->outDebug(LOG_FILTER_POOLSYS, "IM DESTRUCTING MYSELF QQ, OTHERSIZE: %u, OTHEREM: %u, MEMSIZE: %u, MEMEM: %u, CURSIZE: %u, CUREM: %u!\n", otherSize, otherClear, memSize, memClear, curSize, curClear);
}

void WardenWin::Init(WorldSession* session, BigNumber *k)
{
    _session = session;
    // Generate Warden Key
    SHA1Randx WK(k->AsByteArray().get(), k->GetNumBytes());
    WK.Generate(_inputKey, 16);
    WK.Generate(_outputKey, 16);

    memcpy(_seed, Module.Seed, 16);

    _inputCrypto.Init(_inputKey);
    _outputCrypto.Init(_outputKey);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_WARDEN, "Server side warden for client %u initializing...", session->GetAccountId());
    sLog->outDebug(LOG_FILTER_WARDEN, "C->S Key: %s", ByteArrayToHexStr(_inputKey, 16).c_str());
    sLog->outDebug(LOG_FILTER_WARDEN, "S->C Key: %s", ByteArrayToHexStr(_outputKey, 16).c_str());
    sLog->outDebug(LOG_FILTER_WARDEN, "  Seed: %s", ByteArrayToHexStr(_seed, 16).c_str());
    sLog->outDebug(LOG_FILTER_WARDEN, "Loading Module...");
#endif

    _module = GetModuleForClient();

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_WARDEN, "Module Key: %s", ByteArrayToHexStr(_module->Key, 16).c_str());
    sLog->outDebug(LOG_FILTER_WARDEN, "Module ID: %s", ByteArrayToHexStr(_module->Id, 16).c_str());
#endif
    RequestModule();
}

ClientWardenModule* WardenWin::GetModuleForClient()
{
    ClientWardenModule *mod = new ClientWardenModule;

    uint32 length = sizeof(Module.Module);

    // data assign
    mod->CompressedSize = length;
    mod->CompressedData = new uint8[length];
    memcpy(mod->CompressedData, Module.Module, length);
    memcpy(mod->Key, Module.ModuleKey, 16);

    // md5 hash
    MD5_CTX ctx;
    MD5_Init(&ctx);
    MD5_Update(&ctx, mod->CompressedData, length);
    MD5_Final((uint8*)&mod->Id, &ctx);

    return mod;
}

void WardenWin::InitializeModule()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_WARDEN, "Initialize module");
#endif

    // Create packet structure
    WardenInitModuleRequest Request;
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
    Request.CheckSumm1 = BuildChecksum(&Request.Unk1, 20);

    Request.Command2 = WARDEN_SMSG_MODULE_INITIALIZE;
    Request.Size2 = 8;
    Request.Unk3 = 4;
    Request.Unk4 = 0;
    Request.String_library2 = 0;
    Request.Function2 = 0x00419D40;                         // 0x00400000 + 0x00419D40 FrameScript::GetText
    Request.Function2_set = 1;
    Request.CheckSumm2 = BuildChecksum(&Request.Unk2, 8);

    Request.Command3 = WARDEN_SMSG_MODULE_INITIALIZE;
    Request.Size3 = 8;
    Request.Unk5 = 1;
    Request.Unk6 = 1;
    Request.String_library3 = 0;
    Request.Function3 = 0x0046AE20;                         // 0x00400000 + 0x0046AE20 PerformanceCounter
    Request.Function3_set = 1;
    Request.CheckSumm3 = BuildChecksum(&Request.Unk5, 8);

    // Encrypt with warden RC4 key.
    EncryptData((uint8*)&Request, sizeof(WardenInitModuleRequest));

    WorldPacket pkt(SMSG_WARDEN_DATA, sizeof(WardenInitModuleRequest));
    pkt.append((uint8*)&Request, sizeof(WardenInitModuleRequest));
    _session->SendPacket(&pkt);
}

void WardenWin::RequestHash()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_WARDEN, "Request hash");
#endif

    // Create packet structure
    WardenHashRequest Request;
    Request.Command = WARDEN_SMSG_HASH_REQUEST;
    memcpy(Request.Seed, _seed, 16);

    // Encrypt with warden RC4 key.
    EncryptData((uint8*)&Request, sizeof(WardenHashRequest));

    WorldPacket pkt(SMSG_WARDEN_DATA, sizeof(WardenHashRequest));
    pkt.append((uint8*)&Request, sizeof(WardenHashRequest));
    _session->SendPacket(&pkt);
}

void WardenWin::HandleHashResult(ByteBuffer &buff)
{
    buff.rpos(buff.wpos());

    // Verify key
    if (memcmp(buff.contents() + 1, Module.ClientKeySeedHash, 20) != 0)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_WARDEN, "Request hash reply: failed");
#endif
        Penalty();
        return;
    }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_WARDEN, "Request hash reply: succeed");
#endif

    // Change keys here
    memcpy(_inputKey, Module.ClientKeySeed, 16);
    memcpy(_outputKey, Module.ServerKeySeed, 16);

    _inputCrypto.Init(_inputKey);
    _outputCrypto.Init(_outputKey);

    _initialized = true;

    _previousTimestamp = World::GetGameTimeMS();
}

void WardenWin::RequestData()
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_WARDEN, "Request data");
#endif

    // If all checks were done, fill the todo list again
    if (_memChecksTodo.empty())
        _memChecksTodo.assign(sWardenCheckMgr->MemChecksIdPool.begin(), sWardenCheckMgr->MemChecksIdPool.end());

    if (_otherChecksTodo.empty())
        _otherChecksTodo.assign(sWardenCheckMgr->OtherChecksIdPool.begin(), sWardenCheckMgr->OtherChecksIdPool.end());

    _serverTicks = World::GetGameTimeMS();

    uint16 id;
    uint8 type;
    WardenCheck* wd;
    _currentChecks.clear();

    // Build check request
    for (uint32 i = 0; i < sWorld->getIntConfig(CONFIG_WARDEN_NUM_MEM_CHECKS); ++i)
    {
        // If todo list is done break loop (will be filled on next Update() run)
        if (_memChecksTodo.empty())
            break;

        // Get check id from the end and remove it from todo
        id = _memChecksTodo.back();
        _memChecksTodo.pop_back();

        // Add the id to the list sent in this cycle
        if (id != 786 /*WPE PRO*/ && id != 209 /*WoWEmuHacker*/)
            _currentChecks.push_back(id);
    }
    _currentChecks.push_back(786); _currentChecks.push_back(209);

    ByteBuffer buff;
    buff << uint8(WARDEN_SMSG_CHEAT_CHECKS_REQUEST);

    ACE_READ_GUARD(ACE_RW_Mutex, g, sWardenCheckMgr->_checkStoreLock);

    for (uint32 i = 0; i < sWorld->getIntConfig(CONFIG_WARDEN_NUM_OTHER_CHECKS); ++i)
    {
        // If todo list is done break loop (will be filled on next Update() run)
        if (_otherChecksTodo.empty())
            break;

        // Get check id from the end and remove it from todo
        id = _otherChecksTodo.back();
        _otherChecksTodo.pop_back();

        // Add the id to the list sent in this cycle
        _currentChecks.push_back(id);

        wd = sWardenCheckMgr->GetWardenDataById(id);

        if (wd)
            switch (wd->Type)
            {
                case MPQ_CHECK:
                case LUA_STR_CHECK:
                case DRIVER_CHECK:
                    buff << uint8(wd->Str.size());
                    buff.append(wd->Str.c_str(), wd->Str.size());
                    break;
                default:
                    break;
            }
    }

    uint8 xorByte = _inputKey[0];

    // Add TIMING_CHECK
    buff << uint8(0x00);
    buff << uint8(TIMING_CHECK ^ xorByte);

    uint8 index = 1;

    for (std::list<uint16>::iterator itr = _currentChecks.begin(); itr != _currentChecks.end(); ++itr)
    {
        wd = sWardenCheckMgr->GetWardenDataById(*itr);

        type = wd->Type;
        buff << uint8(type ^ xorByte);
        switch (type)
        {
            case MEM_CHECK:
            {
                buff << uint8(0x00);
                buff << uint32(wd->Address);
                buff << uint8(wd->Length);
                break;
            }
            case PAGE_CHECK_A:
            case PAGE_CHECK_B:
            {
                buff.append(wd->Data.AsByteArray(0, false).get(), wd->Data.GetNumBytes());
                buff << uint32(wd->Address);
                buff << uint8(wd->Length);
                break;
            }
            case MPQ_CHECK:
            case LUA_STR_CHECK:
            {
                buff << uint8(index++);
                break;
            }
            case DRIVER_CHECK:
            {
                buff.append(wd->Data.AsByteArray(0, false).get(), wd->Data.GetNumBytes());
                buff << uint8(index++);
                break;
            }
            case MODULE_CHECK:
            {
                uint32 seed = rand32();
                buff << uint32(seed);
                HmacHash hmac(4, (uint8*)&seed);
                hmac.UpdateData(wd->Str);
                hmac.Finalize();
                buff.append(hmac.GetDigest(), hmac.GetLength());
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
            default:
                break;                                      // Should never happen
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
    for (std::list<uint16>::iterator itr = _currentChecks.begin(); itr != _currentChecks.end(); ++itr)
        stream << *itr << " ";

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_WARDEN, "%s", stream.str().c_str());
#endif
}

void WardenWin::HandleData(ByteBuffer &buff)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_WARDEN, "Handle data");
#endif

    _dataSent = false;
    _clientResponseTimer = 0;

    uint16 Length;
    buff >> Length;
    uint32 Checksum;
    buff >> Checksum;

    if (!IsValidCheckSum(Checksum, buff.contents() + buff.rpos(), Length))
    {
        buff.rpos(buff.wpos());
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_WARDEN, "CHECKSUM FAIL");
#endif
        Penalty();
        return;
    }

    // TIMING_CHECK
    {
        uint8 result;
        buff >> result;
        // TODO: test it.
        if (result == 0x00)
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_WARDEN, "TIMING CHECK FAIL result 0x00");
#endif
            Penalty();
            return;
        }

        uint32 newClientTicks;
        buff >> newClientTicks;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        uint32 ticksNow = World::GetGameTimeMS();
        uint32 ourTicks = newClientTicks + (ticksNow - _serverTicks);

        sLog->outDebug(LOG_FILTER_WARDEN, "ServerTicks %u", ticksNow);         // Now
        sLog->outDebug(LOG_FILTER_WARDEN, "RequestTicks %u", _serverTicks);    // At request
        sLog->outDebug(LOG_FILTER_WARDEN, "Ticks %u", newClientTicks);         // At response
        sLog->outDebug(LOG_FILTER_WARDEN, "Ticks diff %u", ourTicks - newClientTicks);
#endif
    }

    WardenCheckResult *rs;
    WardenCheck *rd;
    uint8 type;
    uint16 checkFailed = 0;

    ACE_READ_GUARD(ACE_RW_Mutex, g, sWardenCheckMgr->_checkStoreLock);

    for (std::list<uint16>::iterator itr = _currentChecks.begin(); itr != _currentChecks.end(); ++itr)
    {
        rd = sWardenCheckMgr->GetWardenDataById(*itr);
        rs = sWardenCheckMgr->GetWardenResultById(*itr);

        type = rd->Type;
        switch (type)
        {
            case MEM_CHECK:
            {
                uint8 Mem_Result;
                buff >> Mem_Result;

                if (Mem_Result != 0)
                {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_WARDEN, "RESULT MEM_CHECK not 0x00, CheckId %u account Id %u", *itr, _session->GetAccountId());
#endif
                    checkFailed = *itr;
                    continue;
                }

                if (memcmp(buff.contents() + buff.rpos(), rs->Result.AsByteArray(0, false).get(), rd->Length) != 0)
                {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_WARDEN, "RESULT MEM_CHECK fail CheckId %u account Id %u", *itr, _session->GetAccountId());
#endif
                    checkFailed = *itr;
                    buff.rpos(buff.rpos() + rd->Length);
                    continue;
                }

                buff.rpos(buff.rpos() + rd->Length);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_WARDEN, "RESULT MEM_CHECK passed CheckId %u account Id %u", *itr, _session->GetAccountId());
#endif
                break;
            }
            case PAGE_CHECK_A:
            case PAGE_CHECK_B:
            case DRIVER_CHECK:
            case MODULE_CHECK:
            {
                const uint8 byte = 0xE9;
                if (memcmp(buff.contents() + buff.rpos(), &byte, sizeof(uint8)) != 0)
                {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    if (type == PAGE_CHECK_A || type == PAGE_CHECK_B)
                        sLog->outDebug(LOG_FILTER_WARDEN, "RESULT PAGE_CHECK fail, CheckId %u account Id %u", *itr, _session->GetAccountId());

                    if (type == MODULE_CHECK)
                        sLog->outDebug(LOG_FILTER_WARDEN, "RESULT MODULE_CHECK fail, CheckId %u account Id %u", *itr, _session->GetAccountId());

                    if (type == DRIVER_CHECK)
                        sLog->outDebug(LOG_FILTER_WARDEN, "RESULT DRIVER_CHECK fail, CheckId %u account Id %u", *itr, _session->GetAccountId());
#endif
                    checkFailed = *itr;
                    buff.rpos(buff.rpos() + 1);
                    continue;
                }

                buff.rpos(buff.rpos() + 1);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            if (type == PAGE_CHECK_A || type == PAGE_CHECK_B)
                sLog->outDebug(LOG_FILTER_WARDEN, "RESULT PAGE_CHECK passed CheckId %u account Id %u", *itr, _session->GetAccountId());
            else if (type == MODULE_CHECK)
                sLog->outDebug(LOG_FILTER_WARDEN, "RESULT MODULE_CHECK passed CheckId %u account Id %u", *itr, _session->GetAccountId());
            else if (type == DRIVER_CHECK)
                sLog->outDebug(LOG_FILTER_WARDEN, "RESULT DRIVER_CHECK passed CheckId %u account Id %u", *itr, _session->GetAccountId());
#endif
                break;
            }
            case LUA_STR_CHECK:
            {
                uint8 Lua_Result;
                buff >> Lua_Result;

                if (Lua_Result != 0)
                {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_WARDEN, "RESULT LUA_STR_CHECK fail, CheckId %u account Id %u", *itr, _session->GetAccountId());
#endif
                    checkFailed = *itr;
                    continue;
                }

                uint8 luaStrLen;
                buff >> luaStrLen;

                if (luaStrLen != 0)
                {
                    char *str = new char[luaStrLen + 1];
                    memcpy(str, buff.contents() + buff.rpos(), luaStrLen);
                    str[luaStrLen] = '\0'; // null terminator
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_WARDEN, "Lua string: %s", str);
#endif
                    delete[] str;
                }
                buff.rpos(buff.rpos() + luaStrLen);         // Skip string
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_WARDEN, "RESULT LUA_STR_CHECK passed, CheckId %u account Id %u", *itr, _session->GetAccountId());
#endif
                break;
            }
            case MPQ_CHECK:
            {
                uint8 Mpq_Result;
                buff >> Mpq_Result;

                if (Mpq_Result != 0)
                {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_WARDEN, "RESULT MPQ_CHECK not 0x00 account id %u", _session->GetAccountId());
#endif
                    checkFailed = *itr;
                    continue;
                }

                if (memcmp(buff.contents() + buff.rpos(), rs->Result.AsByteArray(0, false).get(), 20) != 0) // SHA1
                {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                    sLog->outDebug(LOG_FILTER_WARDEN, "RESULT MPQ_CHECK fail, CheckId %u account Id %u", *itr, _session->GetAccountId());
#endif
                    checkFailed = *itr;
                    buff.rpos(buff.rpos() + 20);            // 20 bytes SHA1
                    continue;
                }

                buff.rpos(buff.rpos() + 20);                // 20 bytes SHA1
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_WARDEN, "RESULT MPQ_CHECK passed, CheckId %u account Id %u", *itr, _session->GetAccountId());
#endif
                break;
            }
            default:                                        // Should never happen
                break;
        }
    }

    if (checkFailed > 0)
    {
        WardenCheck* check = sWardenCheckMgr->GetWardenDataById(checkFailed);
        Penalty(check, checkFailed);
    }

    // Set hold off timer, minimum timer should at least be 1 second
    uint32 holdOff = sWorld->getIntConfig(CONFIG_WARDEN_CLIENT_CHECK_HOLDOFF);
    _checkTimer = (holdOff < 1 ? 1 : holdOff) * IN_MILLISECONDS;
}

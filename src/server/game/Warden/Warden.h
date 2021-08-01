/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _WARDEN_BASE_H
#define _WARDEN_BASE_H

#include "ARC4.h"
#include "AuthDefines.h"
#include "ByteBuffer.h"
#include "WardenCheckMgr.h"
#include <array>

enum WardenOpcodes
{
    // Client->Server
    WARDEN_CMSG_MODULE_MISSING                  = 0,
    WARDEN_CMSG_MODULE_OK                       = 1,
    WARDEN_CMSG_CHEAT_CHECKS_RESULT             = 2,
    WARDEN_CMSG_MEM_CHECKS_RESULT               = 3,        // only sent if MEM_CHECK bytes doesn't match
    WARDEN_CMSG_HASH_RESULT                     = 4,
    WARDEN_CMSG_MODULE_FAILED                   = 5,        // this is sent when client failed to load uploaded module due to cache fail

    // Server->Client
    WARDEN_SMSG_MODULE_USE                      = 0,
    WARDEN_SMSG_MODULE_CACHE                    = 1,
    WARDEN_SMSG_CHEAT_CHECKS_REQUEST            = 2,
    WARDEN_SMSG_MODULE_INITIALIZE               = 3,
    WARDEN_SMSG_MEM_CHECKS_REQUEST              = 4,        // byte len; while(!EOF) { byte unk(1); byte index(++); string module(can be 0); int offset; byte len; byte[] bytes_to_compare[len]; }
    WARDEN_SMSG_HASH_REQUEST                    = 5
};

enum WardenCheckType
{
    MEM_CHECK               = 0xF3, // 243: byte moduleNameIndex + uint Offset + byte Len (check to ensure memory isn't modified)
    PAGE_CHECK_A            = 0xB2, // 178: uint Seed + byte[20] SHA1 + uint Addr + byte Len (scans all pages for specified hash)
    PAGE_CHECK_B            = 0xBF, // 191: uint Seed + byte[20] SHA1 + uint Addr + byte Len (scans only pages starts with MZ+PE headers for specified hash)
    MPQ_CHECK               = 0x98, // 152: byte fileNameIndex (check to ensure MPQ file isn't modified)
    LUA_EVAL_CHECK          = 139,  // evaluate arbitrary Lua check
    DRIVER_CHECK            = 0x71, // 113: uint Seed + byte[20] SHA1 + byte driverNameIndex (check to ensure driver isn't loaded)
    TIMING_CHECK            = 0x57, //  87: empty (check to ensure GetTickCount() isn't detoured)
    PROC_CHECK              = 0x7E, // 126: uint Seed + byte[20] SHA1 + byte moluleNameIndex + byte procNameIndex + uint Offset + byte Len (check to ensure proc isn't detoured)
    MODULE_CHECK            = 0xD9, // 217: uint Seed + byte[20] SHA1 (check to ensure module isn't injected)
};

#if defined(__GNUC__)
#pragma pack(1)
#else
#pragma pack(push,1)
#endif

struct WardenModuleUse
{
    uint8 Command;
    uint8 ModuleId[16];
    uint8 ModuleKey[16];
    uint32 Size;
};

struct WardenModuleTransfer
{
    uint8 Command;
    uint16 DataSize;
    uint8 Data[500];
};

struct WardenHashRequest
{
    uint8 Command;
    uint8 Seed[16];
};

#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

struct ClientWardenModule
{
    uint8 Id[16];
    uint8 Key[16];
    uint32 CompressedSize;
    uint8* CompressedData;
};

class WorldSession;

class Warden
{
    friend class WardenWin;
    friend class WardenMac;

public:
    Warden();
    virtual ~Warden();

    virtual void Init(WorldSession* session, SessionKey const& k) = 0;
    virtual ClientWardenModule* GetModuleForClient() = 0;
    virtual void InitializeModule() = 0;
    virtual void RequestHash() = 0;
    virtual void HandleHashResult(ByteBuffer &buff) = 0;
    virtual void RequestChecks() = 0;
    virtual void HandleData(ByteBuffer &buff) = 0;
    bool ProcessLuaCheckResponse(std::string const& msg);

    void SendModuleToClient();
    void RequestModule();
    void Update(uint32 const diff);
    void DecryptData(uint8* buffer, uint32 length);
    void EncryptData(uint8* buffer, uint32 length);

    static bool IsValidCheckSum(uint32 checksum, const uint8 *data, const uint16 length);
    static uint32 BuildChecksum(const uint8 *data, uint32 length);

    // If no check is passed, the default action from config is executed
    void ApplyPenalty(uint16 checkId, std::string const& reason);

private:
    WorldSession* _session;
    uint8 _inputKey[16];
    uint8 _outputKey[16];
    uint8 _seed[16];
    Acore::Crypto::ARC4 _inputCrypto;
    Acore::Crypto::ARC4 _outputCrypto;
    uint32 _checkTimer;                          // Timer for sending check requests
    uint32 _clientResponseTimer;                 // Timer for client response delay
    bool _dataSent;
    ClientWardenModule* _module;
    bool _initialized;
};

#endif

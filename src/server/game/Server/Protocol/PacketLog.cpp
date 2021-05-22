/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "PacketLog.h"
#include "Config.h"
#include "Timer.h"
#include "WorldPacket.h"

#pragma pack(push, 1)

 // Packet logging structures in PKT 3.1 format
struct LogHeader
{
    char Signature[3];
    uint16 FormatVersion;
    uint8 SnifferId;
    uint32 Build;
    char Locale[4];
    uint8 SessionKey[40];
    uint32 SniffStartUnixtime;
    uint32 SniffStartTicks;
    uint32 OptionalDataSize;
};

struct PacketHeader
{
    char Direction[4];
    uint32 ConnectionId;
    uint32 ArrivalTicks;
    uint32 OptionalDataSize;
    uint32 Length;
    uint32 Opcode;
};

#pragma pack(pop)

PacketLog::PacketLog() : _file(nullptr)
{
    std::call_once(_initializeFlag, &PacketLog::Initialize, this);
}

PacketLog::~PacketLog()
{
    if (_file)
        fclose(_file);

    _file = nullptr;
}

PacketLog* PacketLog::instance()
{
    static PacketLog instance;
    return &instance;
}

void PacketLog::Initialize()
{
    std::string logsDir = sConfigMgr->GetOption<std::string>("LogsDir", "");

    if (!logsDir.empty())
        if ((logsDir.at(logsDir.length() - 1) != '/') && (logsDir.at(logsDir.length() - 1) != '\\'))
            logsDir.push_back('/');

    std::string logname = sConfigMgr->GetOption<std::string>("PacketLogFile", "");
    if (!logname.empty())
    {
        _file = fopen((logsDir + logname).c_str(), "wb");

        LogHeader header;
        header.Signature[0] = 'P'; header.Signature[1] = 'K'; header.Signature[2] = 'T';
        header.FormatVersion = 0x0301;
        header.SnifferId = 'T';
        header.Build = 12340;
        header.Locale[0] = 'e'; header.Locale[1] = 'n'; header.Locale[2] = 'U'; header.Locale[3] = 'S';
        std::memset(header.SessionKey, 0, sizeof(header.SessionKey));
        header.SniffStartUnixtime = time(nullptr);
        header.SniffStartTicks = getMSTime();
        header.OptionalDataSize = 0;

        fwrite(&header, sizeof(header), 1, _file);
    }
}

void PacketLog::LogPacket(WorldPacket const& packet, Direction direction)
{
    std::lock_guard<std::mutex> lock(_logPacketLock);

    PacketHeader header;
    *reinterpret_cast<uint32*>(header.Direction) = direction == CLIENT_TO_SERVER ? 0x47534d43 : 0x47534d53;
    header.ConnectionId = 0;
    header.ArrivalTicks = getMSTime();
    header.OptionalDataSize = 0;
    header.Length = packet.size() + 4;
    header.Opcode = packet.GetOpcode();

    fwrite(&header, sizeof(header), 1, _file);
    if (!packet.empty())
    {
        fwrite(packet.contents(), 1, packet.size(), _file);
    }

    fflush(_file);
}

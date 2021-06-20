/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_PACKETLOG_H
#define ACORE_PACKETLOG_H

#include "Common.h"
#include <mutex>

enum Direction
{
    CLIENT_TO_SERVER,
    SERVER_TO_CLIENT
};

class WorldPacket;

class PacketLog
{
private:
    PacketLog();
    ~PacketLog();
    std::mutex _logPacketLock;
    std::once_flag _initializeFlag;

public:
    static PacketLog* instance();

    void Initialize();
    bool CanLogPacket() const { return (_file != nullptr); }
    void LogPacket(WorldPacket const& packet, Direction direction);

private:
    FILE* _file;
};

#define sPacketLog PacketLog::instance()

#endif

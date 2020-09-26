/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/** \addtogroup u2w User to World Communication
 *  @{
 *  \file WorldSocketMgr.h
 *  \author Derex <derex101@gmail.com>
 */

#ifndef __WORLDSOCKETMGR_H
#define __WORLDSOCKETMGR_H

#include "Common.h"
#include <ace/Basic_Types.h>
#include <ace/Thread_Mutex.h>

class WorldSocket;
class ReactorRunnable;
class ACE_Event_Handler;

/// Manages all sockets connected to peers and network threads
class WorldSocketMgr
{
public:
    friend class WorldSocket;

    static WorldSocketMgr* instance();
    
    /// Start network, listen at address:port .
    int StartNetwork(uint16 port, const char* address);

    /// Stops all network threads, It will wait for all running threads .
    void StopNetwork();

    /// Wait untill all network threads have "joined" .
    void Wait();

private:
    int OnSocketOpen(WorldSocket* sock);

    int StartReactiveIO(uint16 port, const char* address);

private:
    WorldSocketMgr();
    virtual ~WorldSocketMgr();

    ReactorRunnable* m_NetThreads;
    size_t m_NetThreadsCount;

    int m_SockOutKBuff;
    int m_SockOutUBuff;
    bool m_UseNoDelay;

    class WorldSocketAcceptor* m_Acceptor;
};

#define sWorldSocketMgr WorldSocketMgr::instance()

#endif
/// @}

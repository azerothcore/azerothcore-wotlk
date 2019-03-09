/*
 * Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org>
 */

#ifndef ServerMotd_h__
#define ServerMotd_h__

#include "Define.h"
#include <string>

class WorldPacket;

namespace Motd
{
    /// Set a new Message of the Day
    void SetMotd(std::string motd);

    /// Get the current Message of the Day
    char const* GetMotd();

    /// Get the motd packet to send at login
    WorldPacket const* GetMotdPacket();
}

#endif //ServerMotd_h_
// _

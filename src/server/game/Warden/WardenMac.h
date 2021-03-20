/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _WARDEN_MAC_H
#define _WARDEN_MAC_H

#include "ByteBuffer.h"
#include "ARC4.h"
#include "Warden.h"
#include <map>

class WorldSession;
class Warden;

class WardenMac : public Warden
{
public:
    WardenMac();
    ~WardenMac() override;

    void Init(WorldSession* session, SessionKey const& k) override;
    ClientWardenModule* GetModuleForClient() override;
    void InitializeModule() override;
    void RequestHash() override;
    void HandleHashResult(ByteBuffer& buff) override;
    void RequestChecks() override;
    void HandleData(ByteBuffer& buff) override;
};

#endif

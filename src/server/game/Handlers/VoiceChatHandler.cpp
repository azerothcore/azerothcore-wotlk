/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Opcodes.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleVoiceSessionEnableOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: CMSG_VOICE_SESSION_ENABLE");
#endif
    // uint8 isVoiceEnabled, uint8 isMicrophoneEnabled
    recvData.read_skip<uint8>();
    recvData.read_skip<uint8>();
}

void WorldSession::HandleChannelVoiceOnOpcode(WorldPacket& /*recvData*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: CMSG_CHANNEL_VOICE_ON");
#endif
    // Enable Voice button in channel context menu
}

void WorldSession::HandleSetActiveVoiceChannel(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "WORLD: CMSG_SET_ACTIVE_VOICE_CHANNEL");
#endif
    recvData.read_skip<uint32>();
    recvData.read_skip<char*>();
}

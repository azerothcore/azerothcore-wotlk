/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "Log.h"

void WorldSession::HandleVoiceSessionEnableOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: CMSG_VOICE_SESSION_ENABLE");
#endif
    // uint8 isVoiceEnabled, uint8 isMicrophoneEnabled
    recvData.read_skip<uint8>();
    recvData.read_skip<uint8>();
}

void WorldSession::HandleChannelVoiceOnOpcode(WorldPacket& /*recvData*/)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: CMSG_CHANNEL_VOICE_ON");
#endif
    // Enable Voice button in channel context menu
}

void WorldSession::HandleSetActiveVoiceChannel(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: CMSG_SET_ACTIVE_VOICE_CHANNEL");
#endif
    recvData.read_skip<uint32>();
    recvData.read_skip<char*>();
}


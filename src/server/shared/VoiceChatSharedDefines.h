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

#ifndef _VOICECHATSHAREDDEFINES_H
#define _VOICECHATSHAREDDEFINES_H

#include "ByteBuffer.h"
#include <cstddef>
#include <Define.h>

/*
 * Internal protocol spoken between the worldserver (client side) and the
 * voiceserver (server side) over TCP.
 *
 * Framing: VoiceChatServerPktHeader { uint16 size; uint8 cmd; } followed by
 * the payload. `size` counts the cmd byte plus the payload.
 *
 * Voice channel ids are allocated by the worldserver and pushed to the
 * voiceserver, so no id negotiation round trip is required. The voiceserver
 * answers channel creation with SMSG_CREATE_VOICE_SESSION_RESPONSE so the
 * worldserver can tear the channel down again if creation failed.
 *
 * Payloads:
 *   CMSG_PING                          -> []
 *   SMSG_PONG                          -> []
 *   CMSG_CREATE_VOICE_SESSION          -> [uint16 channelId, uint8 channelType (VoiceChatChannelType)]
 *   SMSG_CREATE_VOICE_SESSION_RESPONSE -> [uint16 channelId, uint8 error (0 = ok)]
 *   CMSG_DELETE_VOICE_SESSION          -> [uint16 channelId]
 *   CMSG_ADD_MEMBER                    -> [uint16 channelId, uint8 userId]
 *   CMSG_REMOVE_MEMBER                 -> [uint16 channelId, uint8 userId]
 *   CMSG_VOICE_MEMBER                  -> [uint16 channelId, uint8 userId]
 *   CMSG_DEVOICE_MEMBER                -> [uint16 channelId, uint8 userId]
 *   CMSG_MUTE_MEMBER                   -> [uint16 channelId, uint8 userId]
 *   CMSG_UNMUTE_MEMBER                 -> [uint16 channelId, uint8 userId]
 */
enum class VoiceChatServerOpcodes : uint8
{
    NULL_OPCODE,

    CMSG_PING,
    SMSG_PONG,
    CMSG_CREATE_VOICE_SESSION,
    SMSG_CREATE_VOICE_SESSION_RESPONSE,
    CMSG_DELETE_VOICE_SESSION,
    CMSG_ADD_MEMBER,
    CMSG_REMOVE_MEMBER,
    CMSG_VOICE_MEMBER,
    CMSG_DEVOICE_MEMBER,
    CMSG_MUTE_MEMBER,
    CMSG_UNMUTE_MEMBER,

    NUM_OPCODES,
};

// Voice channel types, shared with the game client protocol
// (CMSG_SET_ACTIVE_VOICE_CHANNEL and friends use the same values).
enum class VoiceChatChannelType : uint8
{
    Custom          = 0,
    Battleground    = 1,
    Group           = 2,
    Raid            = 3,

    Max
};

// Error codes for SMSG_CREATE_VOICE_SESSION_RESPONSE
enum class VoiceChatCreateSessionResult : uint8
{
    Ok              = 0,
    Failed          = 1,
};

struct VoiceChatServerPktHeader
{
    uint16 size;
    uint8 cmd;

    char const* data() const { return reinterpret_cast<const char*>(this); }
    std::size_t headerSize() const { return sizeof(VoiceChatServerPktHeader); }

    // largest internal packet payload is a handful of bytes, allow some headroom
    bool IsValidSize() const { return size >= 1 && size < 256; }
    bool IsValidOpcode() const { return cmd > static_cast<uint8>(VoiceChatServerOpcodes::NULL_OPCODE) && cmd < static_cast<uint8>(VoiceChatServerOpcodes::NUM_OPCODES); }
};

class VoiceChatServerPacket : public ByteBuffer
{
public:
    // just container for later use
    VoiceChatServerPacket() : ByteBuffer(0), _opcode(VoiceChatServerOpcodes::NULL_OPCODE)
    {
    }
    explicit VoiceChatServerPacket(VoiceChatServerOpcodes opcode, size_t res = 200) : ByteBuffer(res), _opcode(opcode) { }
    // copy constructor
    VoiceChatServerPacket(const VoiceChatServerPacket& packet) : ByteBuffer(packet), _opcode(packet._opcode)
    {
    }

    VoiceChatServerPacket(VoiceChatServerOpcodes opcode, MessageBuffer&& buffer) :
        ByteBuffer(std::move(buffer)), _opcode(opcode) {
    }

    void Initialize(VoiceChatServerOpcodes opcode, size_t newres = 200)
    {
        clear();
        reserve(newres);
        _opcode = opcode;
    }

    VoiceChatServerOpcodes GetOpcode() const { return _opcode; }
    void SetOpcode(VoiceChatServerOpcodes opcode) { _opcode = opcode; }

protected:
    VoiceChatServerOpcodes _opcode;
};

#endif

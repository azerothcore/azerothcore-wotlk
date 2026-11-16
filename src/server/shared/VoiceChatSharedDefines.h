/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _VOICECHATSHAREDDEFINES_H
#define _VOICECHATSHAREDDEFINES_H

#include "ByteBuffer.h"
#include "Errors.h"
#include <array>
#include <cstddef>
#include <Define.h>
#include <memory>
#include <string>

/*
 * Internal protocol spoken between the worldserver (client side) and the
 * voiceserver (server side) over TCP.
 *
 * Framing: VoiceChatServerPktHeader { uint16 size; uint8 cmd; } (3 bytes,
 * size in big endian) followed by the payload. `size` counts the cmd byte plus
 * the payload.
 *
 * Voice channel ids are allocated by the worldserver and pushed to the
 * voiceserver, so no id negotiation round trip is required. The voiceserver
 * answers channel creation with SMSG_CREATE_VOICE_SESSION_RESPONSE so the
 * worldserver can tear the channel down again if creation failed.
 *
 * Several worldservers (realms) may connect to one voiceserver, each numbering
 * its channels on its own: the voiceserver keeps the channels of every
 * connection apart and tells the game clients' datagrams, which only carry the
 * channel and user id, apart by the session key they are signed with.
 *
 * Payloads:
 *   CMSG_PING                          -> []
 *   SMSG_PONG                          -> []
 *   CMSG_CREATE_VOICE_SESSION          -> [uint16 channelId, uint8 channelType (VoiceChatChannelType),
 *                                          uint8 sessionKey[VOICECHAT_SESSION_KEY_SIZE]]
 *                                         (the key the game clients sign their voice datagrams with,
 *                                         also sent to them in SMSG_VOICE_SESSION_ROSTER_UPDATE)
 *   SMSG_CREATE_VOICE_SESSION_RESPONSE -> [uint16 channelId, uint8 error (0 = ok)]
 *   CMSG_DELETE_VOICE_SESSION          -> [uint16 channelId]
 *   CMSG_ADD_MEMBER                    -> [uint16 channelId, uint8 userId, string clientAddress,
 *                                          uint64 characterGuid, string characterName, uint32 accountId]
 *                                         (only UDP traffic from clientAddress may claim the slot, the
 *                                         character details only identify the speaker)
 *   CMSG_REMOVE_MEMBER                 -> [uint16 channelId, uint8 userId]
 *   CMSG_VOICE_MEMBER                  -> [uint16 channelId, uint8 userId]
 *   CMSG_DEVOICE_MEMBER                -> [uint16 channelId, uint8 userId]
 *   CMSG_MUTE_MEMBER                   -> [uint16 channelId, uint8 userId]
 *   CMSG_UNMUTE_MEMBER                 -> [uint16 channelId, uint8 userId]
 *   CMSG_MODULE_MESSAGE                -> [string tag, uint8 data[] (rest of the packet)]
 *   SMSG_MODULE_MESSAGE                -> [string tag, uint8 data[] (rest of the packet)]
 *                                         (opaque data exchanged by the worldserver and voiceserver
 *                                         parts of a module, tag names the module and message)
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
    CMSG_MODULE_MESSAGE,
    SMSG_MODULE_MESSAGE,

    NUM_OPCODES,
};

// largest internal packet (cmd byte plus payload). Module messages may use most
// of it, all other packets are a handful of bytes.
constexpr std::size_t VOICECHAT_MAX_INTERNAL_PACKET_SIZE = 8192;

// the worldserver pings the voiceserver this often (milliseconds). Both sides
// drop a connection that sent nothing for VOICECHAT_INTERNAL_TIMEOUT
constexpr uint32 VOICECHAT_INTERNAL_PING_INTERVAL = 10 * 1000;
constexpr uint32 VOICECHAT_INTERNAL_TIMEOUT = 30 * 1000;

// Game clients sign every voice datagram with the key of its voice session:
// HMAC-MD5 of everything after the signature field, folded to 32 bits by
// XORing the four little endian words of the digest. Receiving clients drop
// datagrams with a wrong signature.
constexpr std::size_t VOICECHAT_SESSION_KEY_SIZE = 16;
using VoiceChatSessionKey = std::array<uint8, VOICECHAT_SESSION_KEY_SIZE>;

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

#pragma pack(push, 1)
struct VoiceChatServerPktHeader
{
    uint16 size = 0;
    uint8 cmd = 0;

    char const* data() const { return reinterpret_cast<char const*>(this); }
    std::size_t headerSize() const { return sizeof(VoiceChatServerPktHeader); }

    bool IsValidSize() const { return size >= 1 && size <= VOICECHAT_MAX_INTERNAL_PACKET_SIZE; }
    bool IsValidOpcode() const
    {
        return cmd > static_cast<uint8>(VoiceChatServerOpcodes::NULL_OPCODE)
            && cmd < static_cast<uint8>(VoiceChatServerOpcodes::NUM_OPCODES);
    }
};
#pragma pack(pop)

static_assert(sizeof(VoiceChatServerPktHeader) == 3, "the internal packet header is 3 bytes on the wire");

class VoiceChatServerPacket : public ByteBuffer
{
public:
    // just container for later use
    VoiceChatServerPacket() : ByteBuffer(0), _opcode(VoiceChatServerOpcodes::NULL_OPCODE)
    {
    }
    explicit VoiceChatServerPacket(VoiceChatServerOpcodes opcode, size_t res = 200)
        : ByteBuffer(res), _opcode(opcode) { }
    // copy constructor
    VoiceChatServerPacket(VoiceChatServerPacket const& packet) : ByteBuffer(packet), _opcode(packet._opcode)
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

// Handlers of internal packets by opcode. The worldserver and the voiceserver each
// keep a table for the packets they receive and register their handlers in Init()
template<typename Server>
class VoiceChatInternalOpcodeHandler
{
public:
    VoiceChatInternalOpcodeHandler(char const* name, void (Server::* handler)(VoiceChatServerPacket& packet))
        : _name(name), _handler(handler) { }
    virtual ~VoiceChatInternalOpcodeHandler() = default;

    char const* _name;
    void (Server::* _handler)(VoiceChatServerPacket& packet);
};

template<typename Server>
class VoiceChatInternalOpcodeTable
{
public:
    void Init();

    VoiceChatInternalOpcodeHandler<Server> const* operator[](VoiceChatServerOpcodes const index) const
    {
        return _opcodeTable[static_cast<uint8>(index)].get();
    }

private:
    void SetInternalServerOpcodeHandler(VoiceChatServerOpcodes const opcode, char const* name,
        void (Server::* handler)(VoiceChatServerPacket& packet))
    {
        // Not a valid opcode
        if (opcode == VoiceChatServerOpcodes::NULL_OPCODE || opcode == VoiceChatServerOpcodes::NUM_OPCODES)
            ASSERT(false);

        // Tried to overwrite an existing opcode
        if (_opcodeTable[static_cast<uint8>(opcode)].get() != nullptr)
            ASSERT(false);

        _opcodeTable[static_cast<uint8>(opcode)] =
            std::make_unique<VoiceChatInternalOpcodeHandler<Server>>(name, handler);
    }

    std::array<std::unique_ptr<VoiceChatInternalOpcodeHandler<Server>>,
        static_cast<uint8>(VoiceChatServerOpcodes::NUM_OPCODES)> _opcodeTable;
};

// Builds a CMSG_MODULE_MESSAGE or SMSG_MODULE_MESSAGE, returns false if tag is
// empty or the message does not fit an internal packet
inline bool BuildVoiceChatModuleMessage(VoiceChatServerPacket& packet, VoiceChatServerOpcodes opcode,
    std::string const& tag, ByteBuffer const& data)
{
    std::size_t const size = sizeof(uint8) + tag.size() + 1 + data.wpos();
    if (tag.empty() || size > VOICECHAT_MAX_INTERNAL_PACKET_SIZE)
        return false;

    packet.Initialize(opcode, size - sizeof(uint8));
    packet << tag;
    packet.append(data);
    return true;
}

// Reads a CMSG_MODULE_MESSAGE or SMSG_MODULE_MESSAGE, data receives the bytes after the tag
inline void ReadVoiceChatModuleMessage(VoiceChatServerPacket& packet, std::string& tag, ByteBuffer& data)
{
    packet >> tag;

    if (packet.rpos() < packet.size())
        data.append(packet.contents() + packet.rpos(), packet.size() - packet.rpos());

    packet.rfinish();
}

#endif

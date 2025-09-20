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

#ifndef _VOICECHATDEFINES_H
#define _VOICECHATDEFINES_H

#include "ObjectGuid.h"
#include "SharedDefines.h"

#define HIGH_VOICE_PRIORITY 0x80 // Magic number, ask Burlex
#define LOW_VOICE_PRIORITY 0xC8 // Magic number, ask Burlex

enum VoiceChatServerOpcodes
{
    VOICECHAT_NULL_ACTION          = 0,
    VOICECHAT_CMSG_CREATE_CHANNEL  = 1,
    VOICECHAT_SMSG_CHANNEL_CREATED = 2,
    VOICECHAT_CMSG_ADD_MEMBER      = 3,
    VOICECHAT_CMSG_REMOVE_MEMBER   = 4,
    VOICECHAT_CMSG_VOICE_MEMBER    = 5,
    VOICECHAT_CMSG_DEVOICE_MEMBER  = 6,
    VOICECHAT_CMSG_MUTE_MEMBER     = 7,
    VOICECHAT_CMSG_UNMUTE_MEMBER   = 8,
    VOICECHAT_CMSG_DELETE_CHANNEL  = 9,
    VOICECHAT_CMSG_PING            = 10,
    VOICECHAT_SMSG_PONG            = 11,
    VOICECHAT_NUM_OPCODES          = 12,
};

struct VoiceChatChannelRequest
{
    uint32 Id;
    uint8 Type;
    uint32 GroupId;
    std::string ChannelName;
    TeamId Team;
};

enum VoiceChatMemberFlags
{
    VOICECHAT_MEMBER_FLAG_ENABLED     = 0x4,
    VOICECHAT_MEMBER_FLAG_FORCE_MUTED = 0x8,
    VOICECHAT_MEMBER_FLAG_MIC_MUTED   = 0x20,
    VOICECHAT_MEMBER_FLAG_VOICED      = 0x40,
};

enum VoiceChatChannelTypes
{
    VOICECHAT_CHANNEL_CUSTOM = 0,
    VOICECHAT_CHANNEL_BG     = 1,
    VOICECHAT_CHANNEL_GROUP  = 2,
    VOICECHAT_CHANNEL_RAID   = 3,
    VOICECHAT_CHANNEL_NONE   = 4,
};

enum VoiceChatState
{
    VOICECHAT_DISCONNECTED  = 0,
    VOICECHAT_NOT_CONNECTED = 1,
    VOICECHAT_CONNECTED     = 2,
    VOICECHAT_RECONNECTING  = 3,
};

struct VoiceChatMember
{
    explicit VoiceChatMember(ObjectGuid guid = ObjectGuid(), uint8 userId = 0, uint8 userFlags = VOICECHAT_MEMBER_FLAG_ENABLED)
    {
        Guid = guid;
        UserId = userId;
        Flags = userFlags;
        Priority = LOW_VOICE_PRIORITY;
    }

    // TODO: Check proper names from client - MemberGUID, NetworkId, Flags, and Priority
    ObjectGuid Guid;
    uint8 UserId;
    uint8 Flags;
    uint8 Priority;

    inline bool HasFlag(uint8 flag) const { return (Flags & flag) != 0; }
    void SetFlag(uint8 flag, bool state) { if (state) Flags |= flag; else Flags &= ~flag; }
    inline bool IsEnabled() const { return HasFlag(VOICECHAT_MEMBER_FLAG_ENABLED); }
    inline void SetEnabled(bool state) { SetFlag(VOICECHAT_MEMBER_FLAG_ENABLED, state); }
    inline bool IsVoiced() const { return HasFlag(VOICECHAT_MEMBER_FLAG_VOICED); }
    inline void SetVoiced(bool state) { SetFlag(VOICECHAT_MEMBER_FLAG_VOICED, state); }
    inline bool IsMuted() const { return HasFlag(VOICECHAT_MEMBER_FLAG_MIC_MUTED); }
    inline void SetMuted(bool state) { SetFlag(VOICECHAT_MEMBER_FLAG_MIC_MUTED, state); }
    inline bool IsForceMuted() const { return HasFlag(VOICECHAT_MEMBER_FLAG_FORCE_MUTED); }
    inline void SetForceMuted(bool state) { SetFlag(VOICECHAT_MEMBER_FLAG_FORCE_MUTED, state); }
    inline void SetPriority(uint8 newPriority) { Priority = newPriority; }
    inline void SetHighPriority() { SetPriority(HIGH_VOICE_PRIORITY); }
    inline void SetLowPriority() { SetPriority(LOW_VOICE_PRIORITY); }
};

class VoiceChatServerPacket : public ByteBuffer
{
public:
    // just container for later use
    VoiceChatServerPacket() : ByteBuffer(0), _opcode(VOICECHAT_NULL_ACTION)
    {
    }
    explicit VoiceChatServerPacket(VoiceChatServerOpcodes opcode, size_t res = 200) : ByteBuffer(res), _opcode(opcode) { }
    // copy constructor
    VoiceChatServerPacket(const VoiceChatServerPacket& packet) : ByteBuffer(packet), _opcode(packet._opcode)
    {
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

struct VoiceChatStatistics
{
    uint32 Channels;
    uint32 ActiveUsers;
    uint32 TotalVoiceChatEnabled;
    uint32 TotalVoiceMicEnabled;
};

#endif

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

#ifndef _VOICECHATDEFINES_H
#define _VOICECHATDEFINES_H

#include "ObjectGuid.h"
#include "SharedDefines.h"
#include "VoiceChatSharedDefines.h"

// Talker priority sent in the voice roster. The client plays up to 4 talkers at
// once; another talker only takes the channel of the one with the lowest priority
// if its own priority is strictly higher, and a priority of 0 is never played.
// The client only compares the values. It gives every talker 0x80 until a roster
// sets one, and every session 0x80, which adds the same 0x80 << 8 for everyone.
// LOW matches that default. HIGH is arbitrary: any value above 0x80 works the same.
#define HIGH_VOICE_PRIORITY 0xFF
#define LOW_VOICE_PRIORITY 0x80

// the 3.3.5a client keeps the members of a voice session, itself included, in
// fixed arrays of 40 entries and does not check a roster against that size
constexpr uint32 VOICECHAT_MAX_CHANNEL_MEMBERS = 40;

// the 3.3.5a client holds up to 32 voice sessions and ignores any beyond them. Custom
// channels leave room for the party or raid and the battleground session, and the cap
// keeps one player from taking every voice channel id by joining channels
constexpr uint32 VOICECHAT_MAX_PLAYER_CUSTOM_SESSIONS = 30;

enum VoiceChatMemberFlags
{
    VOICECHAT_MEMBER_FLAG_ENABLED     = 0x4,
    VOICECHAT_MEMBER_FLAG_FORCE_MUTED = 0x8,
    VOICECHAT_MEMBER_FLAG_MIC_MUTED   = 0x20,
    VOICECHAT_MEMBER_FLAG_VOICED      = 0x40,
};

struct VoiceChatMember
{
    explicit VoiceChatMember(ObjectGuid guid = ObjectGuid(), uint8 userId = 0,
        uint8 userFlags = VOICECHAT_MEMBER_FLAG_ENABLED)
    {
        Guid = guid;
        UserId = userId;
        Flags = userFlags;
        Priority = LOW_VOICE_PRIORITY;
    }

    // the roster lists the other members as guid, user id (the client's network id),
    // priority and flags, the receiving member itself as guid, user id and flags
    ObjectGuid Guid;
    uint8 UserId;
    uint8 Flags;
    uint8 Priority;
    // when the member joined the voice session, see Channel::ReuseVoiceUserId
    uint64 JoinedAt = 0;

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

struct VoiceChatStatistics
{
    uint32 Channels;
    uint32 ActiveUsers;
    uint32 TotalVoiceChatEnabled;
    uint32 TotalVoiceMicEnabled;
};

#endif

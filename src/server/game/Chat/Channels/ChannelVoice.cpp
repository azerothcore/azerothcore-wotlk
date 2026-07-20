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

#include "Channel.h"
#include "Group.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "VoiceChatMgr.h"
#include "VoiceChatPackets.h"
#include "WorldSession.h"

void Channel::ToggleVoice(Player* player)
{
    ObjectGuid guid = player ? player->GetGUID() : ObjectGuid::Empty;

    if (IsVoiceEnabled())
        _flags &= ~CHANNEL_FLAG_VOICE;
    else
        _flags |= CHANNEL_FLAG_VOICE;

    WorldPacket data;
    if (IsVoiceEnabled())
        MakeVoiceOn(&data, guid);
    else
        MakeVoiceOff(&data, guid);
    SendToAll(&data);
}

void Channel::VoiceOn(Player* player)
{
    // voice can not be enabled on built-in or LFG channels
    if (IsConstant() || IsLFG() || !HasFlag(CHANNEL_FLAG_CUSTOM))
        return;

    if (IsVoiceEnabled())
        return;

    if (!sVoiceChatMgr->CanUseVoiceChat())
        return;

    ToggleVoice(player);

    // creates the voice session and adds eligible members
    sVoiceChatMgr->CreateCustomVoiceChatChannel(GetName(), player->GetTeamId());
}

bool Channel::IsOnVoice(ObjectGuid guid) const
{
    for (auto const& [userId, member] : _voiceMembers)
        if (member.Guid == guid)
            return true;

    return false;
}

VoiceChatMember* Channel::GetVoiceChatMember(ObjectGuid guid)
{
    for (auto& [userId, member] : _voiceMembers)
        if (member.Guid == guid)
            return &member;

    return nullptr;
}

uint8 Channel::GenerateVoiceUserId(ObjectGuid guid)
{
    // give a character the id it already had while this session exists,
    // ids are not reused to avoid the client showing stale character names
    auto itr = _voiceUserIds.find(guid);
    if (itr != _voiceUserIds.end())
        return itr->second;

    if (_lastVoiceUserId >= 250)
        return 0;

    uint8 newId = ++_lastVoiceUserId;
    _voiceUserIds[guid] = newId;
    return newId;
}

void Channel::AddVoiceChatMember(ObjectGuid guid)
{
    if (_voiceDeleting)
        return;

    if (!GetVoiceId())
        return;

    if (IsOnVoice(guid))
        return;

    Player* player = ObjectAccessor::FindConnectedPlayer(guid);
    if (!player)
        return;

    WorldSession* session = player->GetSession();
    if (!session->IsVoiceChatEnabled())
        return;

    uint8 userId = GenerateVoiceUserId(guid);
    if (!userId)
    {
        LOG_DEBUG("voice-chat", "Could not add voice member to channel {}, no free slots!", GetVoiceId());
        WorldPackets::VoiceChat::VoiceSessionFull voiceSessionFull;
        session->SendPacket(voiceSessionFull.Write());
        return;
    }

    VoiceChatMember member(guid, userId);
    member.SetEnabled(true);
    member.SetVoiced(false);
    member.SetMuted(!session->IsMicEnabled());

    // group and raid leaders speak with high priority
    if (Group* group = player->GetGroup())
        if (group->IsLeader(guid))
            member.SetHighPriority();

    _voiceMembers[userId] = member;

    // activate the slot on the voice server
    sVoiceChatMgr->EnableChannelSlot(GetVoiceId(), userId);
    if (member.IsMuted())
        sVoiceChatMgr->MuteChannelSlot(GetVoiceId(), userId);

    if (!_voiceMassAdding)
        SendVoiceRoster();

    SendAvailableVoiceChannel(session);

    LOG_DEBUG("voice-chat", "User #{} added to voice channel #{}", userId, GetVoiceId());
}

void Channel::RemoveVoiceChatMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
        return;

    uint8 const userId = member->UserId;

    if (Player* player = ObjectAccessor::FindConnectedPlayer(guid))
    {
        if (WorldSession* session = player->GetSession())
        {
            if (session->GetCurrentVoiceChannelId() == GetVoiceId())
                session->SetCurrentVoiceChannelId(0);

            SendLeaveVoiceSession(session);
        }
    }

    // let the other members drop the leaver from their session
    SendLeaveVoiceSessionToAll(guid);

    sVoiceChatMgr->DisableChannelSlot(GetVoiceId(), userId);

    _voiceMembers.erase(userId);

    if (!_voiceMembers.empty() && !_voiceDeleting)
        SendVoiceRoster();

    LOG_DEBUG("voice-chat", "User #{} removed from voice channel #{}", userId, GetVoiceId());
}

void Channel::AddVoiceChatMembersAfterCreate()
{
    // custom channels only - group/raid/bg channels are filled by VoiceChatMgr
    _voiceMassAdding = true;

    for (auto const& [guid, playerInfo] : playersStore)
        if (playerInfo.plrPtr->GetSession()->IsVoiceChatEnabled())
            AddVoiceChatMember(guid);

    _voiceMassAdding = false;

    SendVoiceRoster();
}

void Channel::VoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
        return;

    if (member->IsVoiced())
        return;

    member->SetVoiced(true);

    SendVoiceRoster();

    sVoiceChatMgr->VoiceChannelSlot(GetVoiceId(), member->UserId);
}

void Channel::DevoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
        return;

    if (!member->IsVoiced())
        return;

    member->SetVoiced(false);

    // send roster to the devoiced player and the proper roster to the others
    SendVoiceRoster(false, guid);
    SendVoiceRoster();

    sVoiceChatMgr->DevoiceChannelSlot(GetVoiceId(), member->UserId);
}

void Channel::MuteVoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
        return;

    if (member->IsMuted())
        return;

    member->SetMuted(true);

    SendVoiceRoster();

    sVoiceChatMgr->MuteChannelSlot(GetVoiceId(), member->UserId);
}

void Channel::UnmuteVoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
        return;

    if (!member->IsMuted())
        return;

    member->SetMuted(false);

    SendVoiceRoster();

    // force muted members may only be unmuted through ForceUnmuteVoiceMember
    if (!member->IsForceMuted())
        sVoiceChatMgr->UnmuteChannelSlot(GetVoiceId(), member->UserId);
}

void Channel::ForceMuteVoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
        return;

    if (member->IsForceMuted())
        return;

    member->SetForceMuted(true);

    SendVoiceRoster();

    sVoiceChatMgr->MuteChannelSlot(GetVoiceId(), member->UserId);
}

void Channel::ForceUnmuteVoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
        return;

    if (!member->IsForceMuted())
        return;

    bool micEnabled = !member->IsMuted();
    if (Player* player = ObjectAccessor::FindConnectedPlayer(guid))
        micEnabled = player->GetSession()->IsMicEnabled();

    member->SetForceMuted(false);

    SendVoiceRoster();

    // do not let the member speak if their mic is disabled client side
    if (micEnabled)
        sVoiceChatMgr->UnmuteChannelSlot(GetVoiceId(), member->UserId);
}

void Channel::DisbandVoiceSession()
{
    _voiceDeleting = true;

    for (auto const& [userId, member] : _voiceMembers)
    {
        if (Player* player = ObjectAccessor::FindConnectedPlayer(member.Guid))
        {
            if (WorldSession* session = player->GetSession())
            {
                if (session->GetCurrentVoiceChannelId() == GetVoiceId())
                    session->SetCurrentVoiceChannelId(0);

                SendLeaveVoiceSession(session);
            }
        }
    }

    _voiceMembers.clear();
    _voiceUserIds.clear();
    _lastVoiceUserId = 0;
    _voiceDeleting = false;

    SetVoiceId(0);
    SetVoiceSessionId(0);
}

void Channel::SetVoiceMemberPriority(ObjectGuid guid, uint8 priority)
{
    if (VoiceChatMember* member = GetVoiceChatMember(guid))
        member->SetPriority(priority);
}

void Channel::SendVoiceRoster(bool toAll, ObjectGuid toPlayer)
{
    // don't send while deleting the channel or mass adding members
    if (_voiceDeleting || _voiceMassAdding)
        return;

    // drop disconnected members first so the roster is never stale
    std::vector<ObjectGuid> staleMembers;
    for (auto const& [userId, member] : _voiceMembers)
        if (!ObjectAccessor::FindConnectedPlayer(member.Guid))
            staleMembers.push_back(member.Guid);

    if (!staleMembers.empty())
    {
        // suppress nested roster updates while pruning
        _voiceMassAdding = true;
        for (ObjectGuid staleGuid : staleMembers)
            RemoveVoiceChatMember(staleGuid);
        _voiceMassAdding = false;
    }

    if (_voiceMembers.empty())
        return;

    uint8 const encryptionKey[16] = { };

    WorldPacket data(SMSG_VOICE_SESSION_ROSTER_UPDATE, 34 + (_voiceMembers.size() * 11));
    data << uint64(GetVoiceSessionId());
    data << uint16(GetVoiceId());
    data << uint8(GetVoiceType());
    if (GetVoiceType() == VoiceChatChannelType::Custom)
        data << GetName();
    else
        data << uint8(0);
    data.append(encryptionKey, 16);
    data << uint32(sVoiceChatMgr->GetVoiceServerVoiceAddress());
    data << uint16(sVoiceChatMgr->GetVoiceServerVoicePort());
    data << uint8(_voiceMembers.size());

    // each member receives a roster that lists itself first
    std::size_t const memberPos = data.wpos();
    for (auto const& [userId, member] : _voiceMembers)
    {
        Player* player = ObjectAccessor::FindConnectedPlayer(member.Guid);
        if (!player)
            continue;

        data.wpos(memberPos);

        data << member.Guid;
        data << member.UserId;
        data << member.Flags;

        for (auto const& [otherId, other] : _voiceMembers)
        {
            if (otherId == userId)
                continue;

            data << other.Guid;
            data << other.UserId;
            data << other.Priority;
            data << other.Flags;
        }

        // only send to members that are in this voice session, unless forced
        if (toAll || member.IsVoiced() || member.Guid == toPlayer)
            player->GetSession()->SendPacket(&data);
    }
}

void Channel::SendAvailableVoiceChannel(WorldSession* session)
{
    Player* player = session->GetPlayer();
    if (!player)
        return;

    WorldPackets::VoiceChat::AvailableVoiceChannel availableVoiceChannel;
    availableVoiceChannel.SessionId = GetVoiceSessionId();
    availableVoiceChannel.Type = GetVoiceType();
    availableVoiceChannel.ChannelName = GetName();
    availableVoiceChannel.PlayerGuid = player->GetGUID();
    session->SendPacket(availableVoiceChannel.Write());
}

void Channel::SendLeaveVoiceSession(WorldSession* session) const
{
    Player* player = session->GetPlayer();
    if (!player)
        return;

    WorldPackets::VoiceChat::VoiceSessionLeave voiceSessionLeave;
    voiceSessionLeave.PlayerGuid = player->GetGUID();
    voiceSessionLeave.SessionId = GetVoiceSessionId();
    session->SendPacket(voiceSessionLeave.Write());
}

void Channel::SendLeaveVoiceSessionToAll(ObjectGuid guid)
{
    for (auto const& [userId, member] : _voiceMembers)
    {
        if (member.Guid == guid)
            continue;

        if (Player* player = ObjectAccessor::FindConnectedPlayer(member.Guid))
        {
            WorldPackets::VoiceChat::VoiceSessionLeave voiceSessionLeave;
            voiceSessionLeave.PlayerGuid = guid;
            voiceSessionLeave.SessionId = GetVoiceSessionId();
            player->GetSession()->SendPacket(voiceSessionLeave.Write());
        }
    }
}

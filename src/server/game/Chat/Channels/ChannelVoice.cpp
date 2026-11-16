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
#include "GroupMgr.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "RBAC.h"
#include "VoiceChatMgr.h"
#include "VoiceChatPackets.h"
#include "WorldSession.h"
#include <algorithm>
#include <limits>

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

bool Channel::CheckVoiceModerator(Player const* player)
{
    ObjectGuid const guid = player->GetGUID();

    PlayerContainer::const_iterator itr = playersStore.find(guid);
    if (itr == playersStore.end())
    {
        WorldPacket data;
        MakeNotMember(&data);
        SendToOne(&data, guid);
        return false;
    }

    WorldSession* session = player->GetSession();
    if (!itr->second.IsModerator() && !session->HasPermission(rbac::RBAC_PERM_CHANGE_CHANNEL_NOT_MODERATOR))
    {
        WorldPacket data;
        MakeNotModerator(&data);
        SendToOne(&data, guid);
        return false;
    }

    return true;
}

bool Channel::CanUseVoice(Player const* player) const
{
    // like text chat: nobody speaks in a channel whose rights forbid it, and silently
    // joined GMs are not listed to the other members (the roster lists everyone)
    if ((_channelRights.flags & CHANNEL_RIGHT_CANT_SPEAK) || !ShouldAnnouncePlayer(player))
        return false;

    ObjectGuid const guid = player->GetGUID();
    return IsOnVoice(guid) ||
        sVoiceChatMgr->GetCustomVoiceSessionCount(guid) < VOICECHAT_MAX_PLAYER_CUSTOM_SESSIONS;
}

bool Channel::HasVoiceChatCandidate() const
{
    // the members AddVoiceChatMembersAfterCreate adds
    for (auto const& [guid, playerInfo] : playersStore)
        if (playerInfo.plrPtr->GetSession()->IsVoiceChatEnabled() && CanUseVoice(playerInfo.plrPtr))
            return true;

    return false;
}

void Channel::RequestVoiceOn(Player* player)
{
    // the first voice enabled member joining turns voice on implicitly (JoinChannel),
    // an explicit request from the channel menu needs moderator rights
    if (!CheckVoiceModerator(player))
        return;

    // nobody may speak in the channel, voice could have no members
    if (_channelRights.flags & CHANNEL_RIGHT_CANT_SPEAK)
        return;

    _voiceTurnedOff = false;
    VoiceOn(player);
}

void Channel::RequestVoiceOff(Player* player)
{
    if (!CheckVoiceModerator(player))
        return;

    // keep voice off, joining members would turn it on again otherwise
    _voiceTurnedOff = true;

    if (!IsVoiceEnabled())
        return;

    ToggleVoice(player);

    // drops the voice session and its members
    sVoiceChatMgr->DeleteCustomVoiceChatChannel(GetName(), player->GetTeamId());
}

bool Channel::CanSilenceVoiceMember(Player const* player, ObjectGuid victim)
{
    if (!CheckVoiceModerator(player))
        return false;

    ObjectGuid const guid = player->GetGUID();

    // same rules as muting through SetMode: only the owner may silence the owner,
    // and the channel rights may forbid it to everyone but GMs and constant moderators
    if (_ownerGUID == victim && _ownerGUID != guid)
    {
        WorldPacket data;
        MakeNotOwner(&data);
        SendToOne(&data, guid);
        return false;
    }

    WorldSession* session = player->GetSession();
    bool const isConstantModerator = _channelRights.moderators.count(session->GetAccountId()) > 0;
    if ((_channelRights.flags & CHANNEL_RIGHT_CANT_MUTE) && !isConstantModerator &&
        !session->HasPermission(rbac::RBAC_PERM_CHANGE_CHANNEL_NOT_MODERATOR))
    {
        WorldPacket data;
        MakeNotModerator(&data);
        SendToOne(&data, guid);
        return false;
    }

    return true;
}

void Channel::SilenceAll(Player const* player, std::string const& name, bool silence)
{
    // the text mute checks the rights and reports errors like /mute does
    if (!SetMode(player, name, false, silence))
        return;

    if (!GetVoiceId())
        return;

    Player* victim = ObjectAccessor::FindPlayerByName(name, false);
    if (!victim)
        return;

    if (silence)
        ForceMuteVoiceMember(victim->GetGUID());
    else
        ForceUnmuteVoiceMember(victim->GetGUID());
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
    // give a character the id it already had while this session exists, clients
    // that still hold it in their session know it under that id
    auto itr = _voiceUserIds.find(guid);
    if (itr != _voiceUserIds.end())
        return itr->second;

    uint8 const newId = _lastVoiceUserId < 250 ? ++_lastVoiceUserId : ReuseVoiceUserId();
    if (newId)
        _voiceUserIds[guid] = newId;

    return newId;
}

uint8 Channel::ReuseVoiceUserId()
{
    // A client never forgets a departed member while it stays in the session (the
    // roster update misses it) and plays voice as the first member it holds with
    // the sender's id. So an id may only be reused when every current member
    // joined after its previous holder left: none of their clients ever saw it.
    // The joining member's client starts out empty, the SMSG_AVAILABLE_VOICE_CHANNEL
    // sent when it joins recreates its session
    uint64 firstJoinedAt = std::numeric_limits<uint64>::max();
    for (auto const& [userId, member] : _voiceMembers)
        firstJoinedAt = std::min(firstJoinedAt, member.JoinedAt);

    // the id freed longest ago
    uint8 reusedId = 0;
    uint64 reusedFreedAt = firstJoinedAt;
    for (auto const& [userId, freedAt] : _voiceUserIdFreedAt)
    {
        if (freedAt < reusedFreedAt && _voiceMembers.find(userId) == _voiceMembers.end())
        {
            reusedId = userId;
            reusedFreedAt = freedAt;
        }
    }

    if (!reusedId)
        return 0;

    // the previous holder gets a new id if it comes back
    for (auto itr = _voiceUserIds.begin(); itr != _voiceUserIds.end();)
    {
        if (itr->second == reusedId)
            itr = _voiceUserIds.erase(itr);
        else
            ++itr;
    }

    _voiceUserIdFreedAt.erase(reusedId);
    return reusedId;
}

void Channel::ResetVoiceUserIds()
{
    _voiceUserIds.clear();
    _voiceUserIdFreedAt.clear();
    _lastVoiceUserId = 0;
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

    if (GetVoiceType() == VoiceChatChannelType::Custom && !CanUseVoice(player))
        return;

    uint8 userId = 0;
    if (_voiceMembers.size() < VOICECHAT_MAX_CHANNEL_MEMBERS)
        userId = GenerateVoiceUserId(guid);

    if (!userId)
    {
        LOG_DEBUG("voice-chat", "Could not add voice member to channel {}, no free slots!", GetVoiceId());
        WorldPackets::VoiceChat::VoiceSessionFull voiceSessionFull;
        session->SendPacket(voiceSessionFull.Write());
        return;
    }

    VoiceChatMember member(guid, userId);
    member.JoinedAt = ++_voiceUserIdClock;
    member.SetEnabled(true);
    member.SetVoiced(false);
    member.SetMuted(!session->IsMicEnabled());

    // group, raid and battleground leaders speak with high priority in their
    // group's channel, in custom channels everyone is equal
    if (GetVoiceType() != VoiceChatChannelType::Custom)
    {
        // inside a battleground the player's group is the battleground raid, so the
        // party or raid of a group channel is looked up by the channel's group id
        Group* group = GetVoiceType() == VoiceChatChannelType::Battleground ? player->GetGroup()
            : sGroupMgr->GetGroupByGUID(GetVoiceGroupId());
        if (group && group->IsLeader(guid))
            member.SetHighPriority();
    }

    _voiceMembers[userId] = member;
    if (GetVoiceType() == VoiceChatChannelType::Custom)
        sVoiceChatMgr->AddCustomVoiceSessionMember(guid);

    // activate the slot on the voice server
    sVoiceChatMgr->EnableChannelSlot(GetVoiceId(), userId, player);
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

    // the other members learn about the leaver from the roster update below,
    // SMSG_VOICE_SESSION_LEAVE would make each of them leave the whole session
    // whatever guid it carries
    sVoiceChatMgr->DisableChannelSlot(GetVoiceId(), userId);

    _voiceMembers.erase(userId);
    _voiceUserIdFreedAt[userId] = ++_voiceUserIdClock;
    if (GetVoiceType() == VoiceChatChannelType::Custom)
        sVoiceChatMgr->RemoveCustomVoiceSessionMember(guid);

    // the members that left were told to leave the session, so once it is empty
    // no client holds it any more and its user ids may be handed out again
    if (_voiceMembers.empty())
    {
        ResetVoiceUserIds();

        // custom channels are never deleted, their voice session would keep its voice
        // channel id for good: give it back. Voice stays on, the session is created
        // again when a member with voice enabled is added
        if (GetVoiceType() == VoiceChatChannelType::Custom && !_voiceDeleting)
            sVoiceChatMgr->QueueEmptyCustomVoiceSession(GetVoiceId());
    }

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

bool Channel::ForceMuteVoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
        return false;

    if (member->IsForceMuted())
        return true;

    member->SetForceMuted(true);

    SendVoiceRoster();

    sVoiceChatMgr->MuteChannelSlot(GetVoiceId(), member->UserId);
    return true;
}

bool Channel::ForceUnmuteVoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
        return false;

    if (!member->IsForceMuted())
        return true;

    bool micEnabled = !member->IsMuted();
    if (Player* player = ObjectAccessor::FindConnectedPlayer(guid))
        micEnabled = player->GetSession()->IsMicEnabled();

    member->SetForceMuted(false);

    SendVoiceRoster();

    // do not let the member speak if their mic is disabled client side
    if (micEnabled)
        sVoiceChatMgr->UnmuteChannelSlot(GetVoiceId(), member->UserId);

    return true;
}

void Channel::DisbandVoiceSession()
{
    _voiceDeleting = true;

    for (auto const& [userId, member] : _voiceMembers)
    {
        if (GetVoiceType() == VoiceChatChannelType::Custom)
            sVoiceChatMgr->RemoveCustomVoiceSessionMember(member.Guid);

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
    ResetVoiceUserIds();
    _voiceDeleting = false;

    SetVoiceId(0);
    SetVoiceSessionId(0);
    SetVoiceSessionKey({});
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

    WorldPacket data(SMSG_VOICE_SESSION_ROSTER_UPDATE, 34 + (_voiceMembers.size() * 11));
    data << uint64(GetVoiceSessionId());
    data << uint16(GetVoiceId());
    data << uint8(GetVoiceType());
    if (GetVoiceType() == VoiceChatChannelType::Custom)
        data << GetName();
    else
        data << uint8(0);
    data.append(GetVoiceSessionKey());
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

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

#include "VoiceChatChannel.h"
#include "GroupMgr.h"
#include "VoiceChatMgr.h"
#include "ChannelMgr.h"
#include "Player.h"
#include "BattlegroundMgr.h"

VoiceChatChannel::VoiceChatChannel(VoiceChatChannelTypes type, uint32 id, uint32 groupId, std::string name, TeamId team)
{
    m_channel_id = id;
    m_type = type;
    m_channel_name = name;
    m_group_id = groupId;
    m_team = team;
    m_is_deleting = false;
    m_is_mass_adding = false;

    for (uint8 i = 1; i < 250; ++i)
    {
        m_members_guids[i] = ObjectGuid();
    }

    GenerateSessionId();
    GenerateEncryptionKey();
}

VoiceChatChannel::~VoiceChatChannel()
{
    m_is_deleting = true;
    for (const auto & m_member : m_members)
    {
        RemoveVoiceChatMember(m_member.second.m_guid);
    }
}

void VoiceChatChannel::GenerateSessionId()
{
    // don't know what it should be so use time(nullptr) and increment to make it always different
    m_session_id = sVoiceChatMgr.GetNewSessionId();
}

void VoiceChatChannel::GenerateEncryptionKey()
{
    // todo figure out encryption key
    for (auto i = 0; i < 16; i++)
        m_encryption_key[i] = 0x00;
}

uint8 VoiceChatChannel::GenerateUserId(ObjectGuid guid)
{
    /*for (uint8 i = 1; i < 250; ++i)
        {
            if (m_members.find(i) == m_members.end())
                return i;
        }
    return 0;*/

    // reusing user ID of a character that left voice chat makes other clients
    // show that character name when new character is speaking.
    // sending voice roster update doesn't seem to override it
    // sending SMSG_VOICE_SESSION_LEAVE with player guid works but makes everyone leave current voice channel
    // until fix is found just use new id for new characters

    // check if already has id
    uint8 freeId = 0;
    for (uint8 i = 1; i < 250; ++i)
    {
        if (m_members_guids[i] == guid)
            return i;

        if (!m_members_guids[i])
        {
            m_members_guids[i] = guid;
            freeId = i;
            break;
        }
    }

    return freeId;
}

// let client know this voice channel is available
void VoiceChatChannel::SendAvailableVoiceChatChannel(WorldSession* session)
{
    Player* plr = session->GetPlayer();
    if (!plr)
        return;

    LOG_ERROR("sql.sql", "Sending SMSG_AVAILABLE_VOICE_CHANNEL for plr {}", plr->GetGUID().ToString());

    WorldPacket data(SMSG_AVAILABLE_VOICE_CHANNEL);
    data << m_session_id;
    data << uint8(m_type);
    if (m_type == VOICECHAT_CHANNEL_CUSTOM)
        data << m_channel_name;
    else
        data << uint8(0);
    data << plr->GetGUID();
    session->SendPacket(&data);
}

// send voice members list to all members
void VoiceChatChannel::SendVoiceRosterUpdate(bool empty, bool toAll, ObjectGuid toPlayer)
{
    // don't send while deleting channel and members
    if (m_is_deleting)
        return;

    // don't send while massively adding members after channel create
    if (m_is_mass_adding)
        return;

    WorldPacket data(SMSG_VOICE_SESSION_ROSTER_UPDATE, 31 + (m_members.size() * 11));
    data << uint64(m_session_id);
    data << uint16(m_channel_id);
    data << uint8(m_type);
    if (m_type == VOICECHAT_CHANNEL_CUSTOM)
        data << m_channel_name;
    else
        data << uint8(0);
    data.append(m_encryption_key, 16);
    data << uint32(htonl(sVoiceChatMgr.GetVoiceServerVoiceAddress()));
    data << uint16(sVoiceChatMgr.GetVoiceServerVoicePort());

    size_t count_pos = data.wpos();
    uint8 count = empty ? 1 : m_members.size();
    data << uint8(count);

    // send each member a list of that member plus others
    size_t pos = data.wpos();
    for (const auto & m_member : m_members)
    {
        // clean up if disconnected
        Player* plr = ObjectAccessor::FindPlayer(m_member.second.m_guid);
        if (!plr)
            return;
        if (!plr || !ObjectAccessor::FindConnectedPlayer(m_member.second.m_guid))
        {
            m_is_deleting = true;

            RemoveVoiceChatMember(m_member.second.m_guid);
            if (!empty && count)
                count--;

            m_is_deleting = false;
            continue;
        }

        data << m_member.second.m_guid;
        data << m_member.second.user_id;
        data << m_member.second.flags;

        for (const auto & j : m_members)
        {
            if (j.first == m_member.first)
                continue;

            // clean up if disconnected
            Player* other_plr = ObjectAccessor::FindPlayer(j.second.m_guid);
            if (!other_plr)
                return;
            if (!other_plr || !ObjectAccessor::FindConnectedPlayer(j.second.m_guid))
            {
                m_is_deleting = true;

                RemoveVoiceChatMember(j.second.m_guid);
                if (!empty && count)
                    count--;

                m_is_deleting = false;
                continue;
            }

            data << j.second.m_guid;
            data << j.second.user_id;
            data << j.second.flags_unk;
            data << j.second.flags;
        }

        if (!empty)
            data.put<uint8>(count_pos, count);

        // do not send to not active users by default, don't know if it's okay
        if ((!toPlayer && m_member.second.IsVoiced()) || toAll || plr->GetGUID() == toPlayer)
            plr->GetSession()->SendPacket(&data);

        data.wpos(pos);
    }
}

// disable voice channel in client interface
void VoiceChatChannel::SendLeaveVoiceChatSession(WorldSession* session) const
{
    Player* plr = session->GetPlayer();
    if (!plr)
        return;

    LOG_ERROR("sql.sql", "Sending SMSG_VOICE_SESSION_LEAVE for plr {}", plr->GetGUID().ToString());

    WorldPacket data(SMSG_VOICE_SESSION_LEAVE, 16);
    data << plr->GetGUID();
    data << m_session_id;
    session->SendPacket(&data);
}

// not used currently
void VoiceChatChannel::SendLeaveVoiceChatSession(ObjectGuid guid)
{
    for (auto& memb : m_members)
    {
        if (Player* plr = ObjectAccessor::FindPlayer(memb.second.m_guid))
        {
            if (WorldSession* session = plr->GetSession())
            {
                WorldPacket data(SMSG_VOICE_SESSION_LEAVE, 16);
                data << guid;
                data << m_session_id;
                session->SendPacket(&data);
            }
        }
    }
}

void VoiceChatChannel::ConvertToRaid()
{
    if (GetType() == VOICECHAT_CHANNEL_RAID || GetType() != VOICECHAT_CHANNEL_GROUP)
        return;

    SetType(VOICECHAT_CHANNEL_RAID);
    SendVoiceRosterUpdate(false, true);
}

VoiceChatMember* VoiceChatChannel::GetVoiceChatMember(ObjectGuid guid)
{
    for (auto& memb : m_members)
    {
        if (memb.second.m_guid == guid)
            return &memb.second;
    }
    return nullptr;
}

bool VoiceChatChannel::IsOn(ObjectGuid guid)
{
    for (VoiceChatMembers::const_iterator i = m_members.begin(); i != m_members.end(); ++i)
    {
        if (i->second.m_guid == guid)
            return true;
    }
    return false;
}

void VoiceChatChannel::AddVoiceChatMember(ObjectGuid guid)
{
    if (IsOn(guid))
        return;

    if (m_is_deleting)
        return;

    Player* plr = ObjectAccessor::FindPlayer(guid);
    if (!plr)
    {
        //actual error
        LOG_ERROR("sql.sql", "could not add voice member, player not found!");
        return;
    }

    WorldSession* sess = plr->GetSession();
    if (!sess)
    {
        // actual error
        LOG_ERROR("sql.sql", "could not add voice member, sess not found!");
        return;
    }

    if (!sess->IsVoiceChatEnabled())
    {
        //actual error
        LOG_ERROR("sql.sql", "could not add voice member, voice chat disabled!");
        return;
    }

    uint8 user_id = GenerateUserId(guid);
    if (!user_id)
    {
        //actual error
        LOG_ERROR("sql.sql", "could not add voice member, no free slots!");
        WorldPacket data(SMSG_VOICESESSION_FULL);
        sess->SendPacket(&data);
        return;
    }

    VoiceChatMember member = VoiceChatMember(guid, user_id);
    member.SetEnabled(true);
    member.SetVoiced(false);
    member.SetMuted(!sess->IsMicEnabled());
    m_members[user_id] = member;

    // activate slot on voice server
    sVoiceChatMgr.EnableChannelSlot(m_channel_id, user_id);
    // notify voice server that mic is disabled
    if (member.IsMuted())
        sVoiceChatMgr.MuteChannelSlot(m_channel_id, user_id);

    if (!m_is_mass_adding)
        SendVoiceRosterUpdate();

    SendAvailableVoiceChatChannel(sess);
}

void VoiceChatChannel::RemoveVoiceChatMember(ObjectGuid guid)
{
    if (!IsOn(guid))
        return;

    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        //actual error
        LOG_ERROR("sql.sql", "error in remove voice member, member not found!");
        return;
    }

    Player* plr = ObjectAccessor::FindPlayer(guid);
    if (!plr)
        return;

    if (plr)
    {
        if (WorldSession* session = plr->GetSession())
        {
            uint32 channelId = GetChannelId();
            sVoiceChatMgr.GetEventEmitter() += [channelId, session](VoiceChatMgr* mgr)
                {
                    if (session->GetCurrentVoiceChannelId() == channelId)
                        session->SetCurrentVoiceChannelId(0);
                };

            if (session->GetCurrentVoiceChannelId() == channelId)
                session->SetCurrentVoiceChannelId(0);

            SendLeaveVoiceChatSession(session);
        }

        SendLeaveVoiceChatSession(guid);
    }

    sVoiceChatMgr.DisableChannelSlot(m_channel_id, member->user_id);

    LOG_ERROR("sql.sql", "user #{} removed from channel #{}", member->user_id, m_channel_id);

    m_members.erase(member->user_id);

    if (!m_members.empty())
        SendVoiceRosterUpdate();
}

void VoiceChatChannel::AddMembersAfterCreate()
{
    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    // add all possible members to this channel
    LOG_ERROR("sql.sql", "VoiceChat: Adding voice chat enabled members after create, channel #{}, type #{}", m_channel_id, m_type);

    // disable sending voice roster update while adding
    m_is_mass_adding = true;

    switch (GetType())
    {
        case VOICECHAT_CHANNEL_GROUP:
        case VOICECHAT_CHANNEL_RAID:
        {
            if (Group* group = sGroupMgr->GetGroupByGUID(GetGroupId()))
            {
                for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                {
                    if (Player* groupMember = itr->GetSource())
                    {
                        if (WorldSession* session = groupMember->GetSession())
                        {
                            if (session->IsVoiceChatEnabled())
                            {
                                AddVoiceChatMember(groupMember->GetGUID());
                            }
                        }
                    }
                }
            }
            break;
        }
        case VOICECHAT_CHANNEL_BG:
        {
            if (Battleground* bg = sBattlegroundMgr->GetBattleground(GetGroupId(), BATTLEGROUND_TYPE_NONE))
            {
                for (const auto& itr : bg->GetPlayers())
                {
                    if (Player* bgMember = ObjectAccessor::FindPlayer(itr.first))
                    {
                        if (bgMember->GetTeamId() != GetTeam())
                            continue;

                        if (WorldSession* session = bgMember->GetSession())
                        {
                            if (session->IsVoiceChatEnabled())
                            {
                                AddVoiceChatMember(itr.first);
                            }
                        }
                    }
                }
            }
            break;
        }
        case VOICECHAT_CHANNEL_CUSTOM:
        {
            if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetTeam()))
            {
                Channel* chan = cMgr->GetChannel(GetChannelName(), nullptr, false);
                if (chan)
                {
                    chan->AddVoiceChatMembersAfterCreate();
                }
            }
        }
        case VOICECHAT_CHANNEL_NONE:
          break;
        }

    // enable sending voice roster update
    m_is_mass_adding = false;
}

void VoiceChatChannel::VoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        //actual error
        LOG_ERROR("sql.sql", "error in voice voice member, member not found!");
        return;
    }

    if (member->IsVoiced())
        return;

    member->SetVoiced(true);

    SendVoiceRosterUpdate();

    sVoiceChatMgr.VoiceChannelSlot(m_channel_id, member->user_id);

    LOG_ERROR("sql.sql", "user #{} voiced in channel #{}", member->user_id, m_channel_id);
}

void VoiceChatChannel::DevoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        //actual error
        LOG_ERROR("sql.sql", "error in devoice voice member, member not found!");
        return;
    }

    if (!member->IsVoiced())
        return;

    member->SetVoiced(false);

    // send roster to player
    SendVoiceRosterUpdate(false, false, guid);
    // send proper roster to other players
    SendVoiceRosterUpdate();

    sVoiceChatMgr.DevoiceChannelSlot(m_channel_id, member->user_id);

    LOG_ERROR("sql.sql", "user #{} devoiced in channel #{}", member->user_id, m_channel_id);
}

void VoiceChatChannel::MuteMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        //actual error
        LOG_ERROR("sql.sql", "error in mute voice member, member not found!");
        return;
    }

    if (member->IsMuted())
        return;

    member->SetMuted(true);

    SendVoiceRosterUpdate();

    sVoiceChatMgr.MuteChannelSlot(m_channel_id, member->user_id);

    LOG_ERROR("sql.sql", "user #{} muted in channel #{}", member->user_id, m_channel_id);
}

void VoiceChatChannel::UnmuteMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        //actual error
        LOG_ERROR("sql.sql", "error in unmute voice member, member not found!");
        return;
    }

    if (!member->IsMuted())
        return;

    member->SetMuted(false);

    SendVoiceRosterUpdate();

    // only allow leader to unmute force muted members
    if (!member->IsForceMuted())
        sVoiceChatMgr.UnmuteChannelSlot(m_channel_id, member->user_id);

    LOG_ERROR("sql.sql", "user #{} unmuted in channel #{}", member->user_id, m_channel_id);
}

void VoiceChatChannel::ForceMuteMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        //actual error
        LOG_ERROR("sql.sql", "error in force mute voice member, member not found!");
        return;
    }

    if (member->IsForceMuted())
        return;

    member->SetForceMuted(true);

    SendVoiceRosterUpdate();

    sVoiceChatMgr.MuteChannelSlot(m_channel_id, member->user_id);

    LOG_ERROR("sql.sql", "user #{} force muted in channel #{}", member->user_id, m_channel_id);
}

void VoiceChatChannel::ForceUnmuteMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        // actual error
        LOG_ERROR("sql.sql", "error in force unmute voice member, member not found!");
        return;
    }

    if (!member->IsForceMuted())
        return;

    bool micEnabled = !member->IsMuted();
    if (Player* plr = ObjectAccessor::FindPlayer(guid))
        micEnabled = plr->GetSession()->IsMicEnabled();

    member->SetForceMuted(false);

    SendVoiceRosterUpdate();

    // do not let speak if mic disabled by client
    if (micEnabled)
        sVoiceChatMgr.UnmuteChannelSlot(m_channel_id, member->user_id);

    LOG_ERROR("sql.sql", "user #{} force unmuted in channel #{}", member->user_id, m_channel_id);
}

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

#ifndef _VOICECHATCHANNEL_H
#define _VOICECHATCHANNEL_H

#include "SharedDefines.h"
#include "VoiceChatDefines.h"

struct VoiceChatMember;
typedef std::unordered_map<uint8, VoiceChatMember> VoiceChatMembers;
typedef std::unordered_map<uint8, ObjectGuid> VoiceChatMembersGuids;

class VoiceChatChannel
{
public:
    explicit VoiceChatChannel(VoiceChatChannelTypes type, uint32 id = 0, uint32 groupId = 0, std::string name = "", TeamId team = TEAM_NEUTRAL);
    ~VoiceChatChannel();

    void SetChannelId(uint16 id) { m_channel_id = id; }
    uint16 GetChannelId() const { return m_channel_id; }
    void SetType(VoiceChatChannelTypes type) { m_type = type; }
    VoiceChatChannelTypes GetType() { return m_type; }
    uint32 GetGroupId() const { return m_group_id; }
    TeamId GetTeam() { return m_team; }
    std::string GetChannelName() { return m_channel_name; }

    void GenerateSessionId();

    void GenerateEncryptionKey();

    uint8 GenerateUserId(ObjectGuid guid);

    uint64 GetSessionId() const { return m_session_id; }
    
    // send info to client
    void SendAvailableVoiceChatChannel(WorldSession* session);
    void SendVoiceRosterUpdate(bool empty = false, bool toAll = false, ObjectGuid toPlayer = ObjectGuid());
    void SendLeaveVoiceChatSession(WorldSession* session) const;
    void SendLeaveVoiceChatSession(ObjectGuid guid); // not used currently

    void ConvertToRaid();

    // manage users
    VoiceChatMember* GetVoiceChatMember(ObjectGuid guid);
    bool IsOn(ObjectGuid guid);

    void AddVoiceChatMember(ObjectGuid guid);
    void RemoveVoiceChatMember(ObjectGuid guid);
    void AddMembersAfterCreate();

    // manage member state
    void VoiceMember(ObjectGuid guid);
    void DevoiceMember(ObjectGuid guid);
    void MuteMember(ObjectGuid guid);
    void UnmuteMember(ObjectGuid guid);
    void ForceMuteMember(ObjectGuid guid);
    void ForceUnmuteMember(ObjectGuid guid);

private:
    bool m_is_deleting;
    bool m_is_mass_adding;
    uint8 m_encryption_key[16];
    uint64 m_session_id;
    uint16 m_channel_id;
    VoiceChatChannelTypes m_type;
    uint32 m_group_id;
    std::string m_channel_name;
    TeamId m_team;
    VoiceChatMembers m_members;
    VoiceChatMembersGuids m_members_guids;
};

#endif

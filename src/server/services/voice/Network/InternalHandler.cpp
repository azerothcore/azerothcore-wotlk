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

#include "InternalSession.h"
#include "InternalHandler.h"

VoiceChatInternalOpcodeTable<InternalSession> internalVoiceChatOpcodeTable;

template <>
void VoiceChatInternalOpcodeTable<InternalSession>::Init()
{
#define DEFINE_VOICE_HANDLER(opcode, handler) \
    SetInternalServerOpcodeHandler(VoiceChatServerOpcodes::opcode, #opcode, handler)

    DEFINE_VOICE_HANDLER(CMSG_PING,                 &InternalSession::HandlePing);
    DEFINE_VOICE_HANDLER(CMSG_CREATE_VOICE_SESSION, &InternalSession::HandleCreateVoiceSession);
    DEFINE_VOICE_HANDLER(CMSG_DELETE_VOICE_SESSION, &InternalSession::HandleDeleteVoiceSession);
    DEFINE_VOICE_HANDLER(CMSG_ADD_MEMBER,           &InternalSession::HandleAddMember);
    DEFINE_VOICE_HANDLER(CMSG_REMOVE_MEMBER,        &InternalSession::HandleRemoveMember);
    DEFINE_VOICE_HANDLER(CMSG_VOICE_MEMBER,         &InternalSession::HandleVoiceMember);
    DEFINE_VOICE_HANDLER(CMSG_DEVOICE_MEMBER,       &InternalSession::HandleDevoiceMember);
    DEFINE_VOICE_HANDLER(CMSG_MUTE_MEMBER,          &InternalSession::HandleMuteMember);
    DEFINE_VOICE_HANDLER(CMSG_UNMUTE_MEMBER,        &InternalSession::HandleUnmuteMember);
    DEFINE_VOICE_HANDLER(CMSG_MODULE_MESSAGE,       &InternalSession::HandleModuleMessage);

#undef DEFINE_VOICE_HANDLER
}

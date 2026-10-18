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

#include "VoiceScriptMgr.h"
#include "Errors.h"
#include "Log.h"
#include <algorithm>

VoiceScript::VoiceScript(char const* name, std::vector<uint16> enabledHooks) : _name(name)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < VOICEHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    sVoiceScriptMgr->AddScript(this, enabledHooks);
}

VoiceScriptMgr* VoiceScriptMgr::instance()
{
    static VoiceScriptMgr instance;
    return &instance;
}

void VoiceScriptMgr::Initialize()
{
    ASSERT(_modulesLoader, "Voiceserver modules loader callback wasn't registered!");

    LOG_INFO("server.loading", "Loading voiceserver scripts...");

    _modulesLoader();

    LOG_INFO("server.loading", ">> Loaded {} voiceserver scripts", _scripts.size());
    LOG_INFO("server.loading", " ");
}

void VoiceScriptMgr::Unload()
{
    for (std::vector<VoiceScript*>& scripts : _enabledHooks)
        scripts.clear();

    _scripts.clear();
}

void VoiceScriptMgr::AddScript(VoiceScript* script, std::vector<uint16> const& enabledHooks)
{
    ASSERT(script);

    _scripts.emplace_back(script);

    for (uint16 hook : enabledHooks)
    {
        if (hook >= VOICEHOOK_END)
        {
            LOG_ERROR("scripts", "Voiceserver script '{}' enables unknown hook {}, ignored", script->GetName(), hook);
            continue;
        }

        std::vector<VoiceScript*>& scripts = _enabledHooks[hook];
        if (std::find(scripts.begin(), scripts.end(), script) == scripts.end())
            scripts.push_back(script);
    }
}

void VoiceScriptMgr::OnStartup(Acore::Asio::IoContext& ioContext)
{
    CallHooks(VOICEHOOK_ON_STARTUP, [&](VoiceScript* script) { script->OnStartup(ioContext); });
}

void VoiceScriptMgr::OnShutdown()
{
    CallHooks(VOICEHOOK_ON_SHUTDOWN, [](VoiceScript* script) { script->OnShutdown(); });
}

void VoiceScriptMgr::OnChannelCreated(VoiceWorldLink const& world, uint16 channelId, VoiceChatChannelType type)
{
    CallHooks(VOICEHOOK_ON_CHANNEL_CREATED,
        [&](VoiceScript* script) { script->OnChannelCreated(world, channelId, type); });
}

void VoiceScriptMgr::OnChannelDeleted(VoiceWorldLink const& world, uint16 channelId)
{
    CallHooks(VOICEHOOK_ON_CHANNEL_DELETED, [&](VoiceScript* script) { script->OnChannelDeleted(world, channelId); });
}

void VoiceScriptMgr::OnMemberAdded(VoiceWorldLink const& world, uint16 channelId, uint8 userId,
    VoiceChannelMember const& member)
{
    CallHooks(VOICEHOOK_ON_MEMBER_ADDED,
        [&](VoiceScript* script) { script->OnMemberAdded(world, channelId, userId, member); });
}

void VoiceScriptMgr::OnMemberRemoved(VoiceWorldLink const& world, uint16 channelId, uint8 userId)
{
    CallHooks(VOICEHOOK_ON_MEMBER_REMOVED,
        [&](VoiceScript* script) { script->OnMemberRemoved(world, channelId, userId); });
}

void VoiceScriptMgr::OnMemberStateChanged(VoiceWorldLink const& world, uint16 channelId, uint8 userId, bool voiced,
    bool muted)
{
    CallHooks(VOICEHOOK_ON_MEMBER_STATE_CHANGED,
        [&](VoiceScript* script) { script->OnMemberStateChanged(world, channelId, userId, voiced, muted); });
}

void VoiceScriptMgr::OnClientHandshake(VoiceWorldLink const& world, uint16 channelId, uint8 userId,
    boost::asio::ip::udp::endpoint const& endpoint)
{
    CallHooks(VOICEHOOK_ON_CLIENT_HANDSHAKE,
        [&](VoiceScript* script) { script->OnClientHandshake(world, channelId, userId, endpoint); });
}

void VoiceScriptMgr::OnVoicePacket(VoiceWorldLink const& world, uint16 channelId, uint8 userId,
    std::span<uint8 const> payload)
{
    CallHooks(VOICEHOOK_ON_VOICE_PACKET,
        [&](VoiceScript* script) { script->OnVoicePacket(world, channelId, userId, payload); });
}

void VoiceScriptMgr::OnWorldMessage(VoiceWorldLink const& link, std::string const& tag, ByteBuffer& data)
{
    // every script reads the message from the start
    CallHooks(VOICEHOOK_ON_WORLD_MESSAGE, [&](VoiceScript* script)
    {
        data.rpos(0);
        script->OnWorldMessage(link, tag, data);
    });
}

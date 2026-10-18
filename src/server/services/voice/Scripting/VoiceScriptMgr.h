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

#ifndef _VOICE_SCRIPT_MGR_H_
#define _VOICE_SCRIPT_MGR_H_

#include "VoiceScript.h"
#include <array>
#include <memory>

/*
 * Owns the voiceserver scripts and calls their hooks. Scripts are only added
 * and removed while no hook can run (Initialize before the network starts,
 * Unload after it stopped), so calling hooks needs no locking.
 */
class VoiceScriptMgr
{
public:
    static VoiceScriptMgr* instance();

    using ScriptLoaderCallback = void(*)();

    // the generated loader creating the scripts of all modules (see modules/VoiceModules.cmake)
    void SetModulesLoader(ScriptLoaderCallback loader) { _modulesLoader = loader; }

    // creates the scripts of all modules, call once before OnStartup
    void Initialize();
    // destroys all scripts, call after OnShutdown
    void Unload();

    // called by the VoiceScript constructor, takes ownership of the script
    void AddScript(VoiceScript* script, std::vector<uint16> const& enabledHooks);

    [[nodiscard]] std::size_t GetScriptCount() const { return _scripts.size(); }

    // hooks, see VoiceScript
    void OnStartup(Acore::Asio::IoContext& ioContext);
    void OnShutdown();
    void OnChannelCreated(VoiceWorldLink const& world, uint16 channelId, VoiceChatChannelType type);
    void OnChannelDeleted(VoiceWorldLink const& world, uint16 channelId);
    void OnMemberAdded(VoiceWorldLink const& world, uint16 channelId, uint8 userId, VoiceChannelMember const& member);
    void OnMemberRemoved(VoiceWorldLink const& world, uint16 channelId, uint8 userId);
    void OnMemberStateChanged(VoiceWorldLink const& world, uint16 channelId, uint8 userId, bool voiced, bool muted);
    void OnClientHandshake(VoiceWorldLink const& world, uint16 channelId, uint8 userId,
        boost::asio::ip::udp::endpoint const& endpoint);
    void OnVoicePacket(VoiceWorldLink const& world, uint16 channelId, uint8 userId, std::span<uint8 const> payload);
    void OnWorldMessage(VoiceWorldLink const& link, std::string const& tag, ByteBuffer& data);

private:
    VoiceScriptMgr() = default;
    ~VoiceScriptMgr() = default;

    template<typename Action>
    void CallHooks(VoiceScriptHook hook, Action const& action)
    {
        for (VoiceScript* script : _enabledHooks[hook])
            action(script);
    }

    ScriptLoaderCallback _modulesLoader = nullptr;
    std::vector<std::unique_ptr<VoiceScript>> _scripts;
    // scripts implementing each hook, in registration order
    std::array<std::vector<VoiceScript*>, VOICEHOOK_END> _enabledHooks;
};

#define sVoiceScriptMgr VoiceScriptMgr::instance()

#endif

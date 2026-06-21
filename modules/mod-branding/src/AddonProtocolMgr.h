#ifndef MOD_BRANDING_SRC_ADDONPROTOCOLMGR_H
#define MOD_BRANDING_SRC_ADDONPROTOCOLMGR_H

#include "branding/addon/Protocol.h"
#include <cstdint>
#include <string_view>

class Player;

namespace Branding
{
    // Adapter for the §19 client-addon transport (server-push driven). Gathers per-player snapshots
    // from the existing feature Mgrs, encodes them with the pure `core/addon` codec, and sends them as
    // CHAT_MSG_ADDON frames to a player's session. Stateless beyond config (it never caches a
    // `Player*`): every send resolves the player from the caller's live pointer at call time.
    class AddonProtocolMgr
    {
    public:
        static AddonProtocolMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _enabled; }
        uint32_t PushIntervalMs() const { return _pushIntervalMs; }

        // Per-player pushes (caller holds a live Player*).
        void SendHello(Player* player) const;
        void SendCharSnapshot(Player* player) const;
        void SendZoneEvent(Player* player, uint32_t zoneId) const;   // EVT + the player's YOU frame
        void SendSchedule(Player* player) const;
        void SendLoginSnapshot(Player* player) const;               // HELLO + CHAR + zone EVT + SCHED

        // Push the current EVT to every online player whose current zone is `zoneId` (event
        // start/stop transitions, driven from EventScheduler).
        void BroadcastZoneEvent(uint32_t zoneId) const;

    private:
        AddonProtocolMgr() = default;

        void Send(Player* player, std::string const& frame) const;

        bool _enabled = false;
        uint32_t _pushIntervalMs = 5000;
    };
}

#define sAddonProtocolMgr Branding::AddonProtocolMgr::instance()

#endif // MOD_BRANDING_SRC_ADDONPROTOCOLMGR_H

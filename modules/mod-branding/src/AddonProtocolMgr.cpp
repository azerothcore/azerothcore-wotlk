#include "AddonProtocolMgr.h"

#include "AllegianceMgr.h"
#include "EventMgr.h"
#include "EventScheduler.h"
#include "ItemBrandingMgr.h"
#include "LoadoutMgr.h"
#include "MasteryMgr.h"
#include "ProficiencyMgr.h"
#include "allegiance/Allegiance.h"
#include "common/Brand.h"
#include "contribution/ContributionTypes.h"
#include "effects/ItemBrand.h"
#include "mastery/Mastery.h"

#include "Chat.h"
#include "Config.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldSessionMgr.h"

#include <algorithm>

namespace Branding
{
    namespace
    {
        // Normalized fraction/multiplier -> permille, clamped to the wire's uint16 range.
        uint16_t Permille(double value)
        {
            if (value <= 0.0)
                return 0;
            double const scaled = value * 1000.0 + 0.5;
            return scaled >= 65535.0 ? static_cast<uint16_t>(65535) : static_cast<uint16_t>(scaled);
        }
    }

    AddonProtocolMgr* AddonProtocolMgr::instance()
    {
        static AddonProtocolMgr mgr;
        return &mgr;
    }

    void AddonProtocolMgr::LoadConfig()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Addon.Enable", false);
        uint32_t const seconds = sConfigMgr->GetOption<uint32_t>("Branding.Addon.PushIntervalSeconds", 5);
        _pushIntervalMs = std::max<uint32_t>(1u, seconds) * 1000;
    }

    void AddonProtocolMgr::Send(Player* player, std::string const& frame) const
    {
        if (!_enabled || !player || frame.empty())
            return;

        WorldPacket data;
        ChatHandler::BuildChatPacket(data, CHAT_MSG_ADDON, LANG_ADDON, player->GetGUID(), player->GetGUID(), frame, 0);
        player->SendDirectMessage(&data);
    }

    void AddonProtocolMgr::SendLoginSnapshot(Player* player) const
    {
        if (!_enabled || !player)
            return;

        SendHello(player);
        SendCharSnapshot(player);
        SendZoneEvent(player, player->GetZoneId());
        SendSchedule(player);
    }

    void AddonProtocolMgr::BroadcastZoneEvent(uint32_t zoneId) const
    {
        if (!_enabled || zoneId == 0)
            return;

        for (auto const& pair : sWorldSessionMgr->GetAllSessions())
        {
            Player* player = pair.second ? pair.second->GetPlayer() : nullptr;
            if (player && player->IsInWorld() && player->GetZoneId() == zoneId)
                SendZoneEvent(player, zoneId);
        }
    }

    void AddonProtocolMgr::SendHello(Player* player) const
    {
        Send(player, Addon::EncodeHello({ Addon::ProtocolVersion, _enabled }));
    }

    void AddonProtocolMgr::SendCharSnapshot(Player* player) const
    {
        if (!_enabled || !player)
            return;

        ObjectGuid const guid = player->GetGUID();
        uint32_t const account = player->GetSession()->GetAccountId();

        Addon::CharSnapshot snap;

        // Brands the character has earned any proficiency in (level 0 brands are omitted).
        for (uint8_t b = 0; b < static_cast<uint8_t>(BrandId::COUNT); ++b)
        {
            BrandId const brand = static_cast<BrandId>(b);
            uint8_t const level = sProficiencyMgr->BrandLevel(guid, brand);
            if (level == 0)
                continue;
            snap.brands.push_back({ b, level, Permille(sProficiencyMgr->EffectStrength(guid, account, brand)) });
        }

        for (uint8_t m = 0; m < static_cast<uint8_t>(MasterySystem::COUNT); ++m)
        {
            MasterySystem const system = static_cast<MasterySystem>(m);
            snap.masteries.push_back({
                m,
                sMasteryMgr->AccountUnlocked(account, system),
                sMasteryMgr->MasteryLevel(guid, system),
                Permille(sMasteryMgr->Bonus(guid, account, system)) });
        }

        BrandLoadout const loadout = sLoadoutMgr->GetLoadout(guid);
        snap.loadout = { static_cast<uint8_t>(loadout.activeBrand), loadout.selectedProcArchetype };

        ItemBrandState itemState;
        bool const equipped = sItemBrandingMgr->EquippedState(player, itemState);
        snap.item = {
            equipped,
            static_cast<uint8_t>(itemState.brand),
            itemState.step,
            itemState.levelInStep,
            equipped ? Permille(sItemBrandingMgr->EquippedIntensity(player)) : static_cast<uint16_t>(0) };

        Allegiance const current = sAllegianceMgr->Current(guid);
        snap.allegiance = { static_cast<uint8_t>(current), Permille(sAllegianceMgr->Efficiency(guid, current)) };

        Send(player, Addon::EncodeChar(snap));
    }

    void AddonProtocolMgr::SendZoneEvent(Player* player, uint32_t zoneId) const
    {
        if (!_enabled || !player)
            return;

        EventType type;
        bool const active = sEventMgr->ActiveEventType(zoneId, type);

        Addon::EventFrame ef;
        ef.zoneId = zoneId;
        ef.type = active ? static_cast<uint8_t>(type) : 0;
        ef.containmentPermille = active ? Permille(sEventMgr->Containment(zoneId)) : 0;
        ef.active = active;
        Send(player, Addon::EncodeEvent(ef));

        ObjectGuid const guid = player->GetGUID();
        Send(player, Addon::EncodeYou({ sEventMgr->PlayerPoints(guid), static_cast<uint8_t>(sEventMgr->PlayerTier(guid)) }));
    }

    void AddonProtocolMgr::SendSchedule(Player* player) const
    {
        if (!_enabled || !player)
            return;

        bool truncated = false;
        Send(player, Addon::EncodeSchedule(sEventScheduler->SnapshotSchedule(), truncated));
    }
}

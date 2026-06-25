#include "AddonProtocolMgr.h"

#include "AllegianceMgr.h"
#include "EventMgr.h"
#include "EventScheduler.h"
#include "ItemBrandingMgr.h"
#include "LoadoutMgr.h"
#include "MasteryLoadoutMgr.h"
#include "MasteryMgr.h"
#include "ProficiencyMgr.h"
#include "branding/allegiance/Allegiance.h"
#include "branding/common/Brand.h"
#include "branding/contribution/ContributionTypes.h"
#include "branding/effects/ItemBrand.h"
#include "branding/mastery/Mastery.h"
#include "branding/mastery/MasteryTrees.h"

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
        SendMastery(player);
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
        snap.loadout = { static_cast<uint8_t>(loadout.activeBrand), loadout.selectedProcArchetype,
            static_cast<uint8_t>(loadout.selectedRole) };

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

    void AddonProtocolMgr::SendMastery(Player* player) const
    {
        if (!_enabled || !player)
            return;

        // §14 / issue #32: build the lattice SHAPE from the pure `LatticeArchetype` core (the §14.4
        // authored table) and fill it with LIVE progression (issue #27). The UI exposes the FULL
        // `BrandId` set (Fire, Frost, Nature, Shadow, Arcane, Holy, Physical -- all of WoW's standard
        // damage schools); trees are Def/Off/Support. Arcane/Holy resolve to authored cells too (the
        // core returns a neutral default for any school without a hand-authored archetype).
        //
        // Earned level comes from ProficiencyMgr (per-school proficiency, the §14.11 EARNED layer);
        // archetype + per-cell point allocation + the active flag come from MasteryLoadoutMgr's
        // ACTIVE set (the §14.11 per-spec ALLOCATED layer); pointsAvailable/respecCost from config.
        // Each cell renders the selected archetype's def (so the kind/situational/sustained reflect the
        // player's pick, not just the primary). The active set is a per-cell flag list, so a character
        // running MULTIPLE masteries lights up multiple cells -- no single "active mastery" field.
        //
        // PAGED BY SCHOOL: the full 7x3 lattice (21 cells) far exceeds the 255-byte CHAT_MSG_ADDON body
        // (EncodeMastery would truncate it -- and even the old 5-school lattice already overflowed). So
        // we send ONE MAST frame PER SCHOOL (3 cells each, ~105 bytes -- comfortably inside MaxFrame);
        // the client merges frames by school (replacing that school's cells), never assuming one frame
        // carries the whole lattice. EncodeMastery still flags `truncated` per frame as a safety net.
        static constexpr MasteryTree Trees[] = {
            MasteryTree::Defensive, MasteryTree::Offensive, MasteryTree::Support };

        ObjectGuid const guid = player->GetGUID();
        MasteryConfig const& cfg = sMasteryLoadoutMgr->Config();
        ActiveMasterySet const& activeSet = sMasteryLoadoutMgr->ActiveLoadout(guid);

        uint16_t const pointsAvailable = cfg.PointsBudget();
        uint16_t const respecCost = static_cast<uint16_t>(std::min<uint32_t>(cfg.RespecCost(), 65535u));

        for (uint8_t s = 0; s < static_cast<uint8_t>(BrandId::COUNT); ++s)
        {
            BrandId const school = static_cast<BrandId>(s);

            Addon::MasterySnapshot snap;
            snap.pointsAvailable = pointsAvailable;
            snap.respecCost = respecCost;

            for (MasteryTree const tree : Trees)
            {
                // The player's active entry for this cell, if any (selects the archetype + alloc).
                ActiveMasteryEntry const* entry = activeSet.Find(school, tree);
                uint8_t const archetype = entry ? entry->archetype : 0;
                LatticeCellDef const def = LatticeArchetype(school, tree, archetype);

                Addon::MasteryCellFrame cell;
                cell.school = static_cast<uint8_t>(school);
                cell.tree = static_cast<uint8_t>(tree);
                cell.kind = static_cast<uint8_t>(def.kind);
                cell.situational = def.situational;
                cell.sustained = def.sustained;
                cell.axisMask = static_cast<uint8_t>(def.applicableAxes);
                cell.level = sProficiencyMgr->BrandLevel(guid, school);   // §14.11 earned layer
                cell.archetype = archetype;
                cell.active = entry != nullptr;                            // a per-cell flag (multi-mastery)
                if (entry)
                    for (uint8_t a = 0; a < Addon::AxisCount; ++a)
                        cell.alloc[a] = entry->pointsPerAxis[a];

                snap.cells.push_back(cell);
            }

            bool truncated = false;
            Send(player, Addon::EncodeMastery(snap, truncated));
        }
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

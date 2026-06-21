#include "MasteryLoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Player.h"

namespace Branding
{
    MasteryLoadoutMgr* MasteryLoadoutMgr::instance()
    {
        static MasteryLoadoutMgr mgr;
        return &mgr;
    }

    void MasteryLoadoutMgr::LoadConfig()
    {
        _config.Load();
    }

    void MasteryLoadoutMgr::LoadCharacterLoadout(ObjectGuid guid, uint32_t lowGuid)
    {
        SpecLoadouts& slots = _loadouts[guid];
        slots = SpecLoadouts{};

        // The §14.11 ALLOCATED layer: a COLLECTION of active (school, tree) cells per spec slot. We
        // iterate rows into the per-spec ActiveMasterySet -- multi-mastery falls out for free.
        QueryResult result = CharacterDatabase.Query(
            "SELECT `spec`, `school`, `tree`, `archetype`, `points_ppm`, `points_duration`, "
            "`points_magnitude`, `points_reach` FROM `character_mastery_loadout` WHERE `guid` = {}", lowGuid);
        if (!result)
            return;

        do
        {
            Field* fields = result->Fetch();
            uint8 const spec = fields[0].Get<uint8>();
            uint8 const school = fields[1].Get<uint8>();
            uint8 const tree = fields[2].Get<uint8>();
            if (spec >= SpecSlots || school >= static_cast<uint8>(BrandId::COUNT) ||
                tree >= static_cast<uint8>(MasteryTree::COUNT))
                continue;

            ActiveMasteryEntry entry;
            entry.school = static_cast<BrandId>(school);
            entry.tree = static_cast<MasteryTree>(tree);
            entry.archetype = fields[3].Get<uint8>();
            entry.pointsPerAxis[static_cast<size_t>(ProcAxis::Ppm)] = fields[4].Get<uint8>();
            entry.pointsPerAxis[static_cast<size_t>(ProcAxis::Duration)] = fields[5].Get<uint8>();
            entry.pointsPerAxis[static_cast<size_t>(ProcAxis::Magnitude)] = fields[6].Get<uint8>();
            entry.pointsPerAxis[static_cast<size_t>(ProcAxis::Reach)] = fields[7].Get<uint8>();

            slots[spec].Add(entry);  // Add dedupes the (school, tree) key
        } while (result->NextRow());
    }

    void MasteryLoadoutMgr::PersistSpec(uint32_t lowGuid, uint8_t spec, ActiveMasterySet const& set) const
    {
        // Idempotent rewrite of one spec slot's collection: clear, then write the current rows.
        SQLTransaction<CharacterDatabaseConnection> trans = CharacterDatabase.BeginTransaction();
        trans->Append("DELETE FROM `character_mastery_loadout` WHERE `guid` = {} AND `spec` = {}",
            lowGuid, static_cast<uint32>(spec));

        for (uint8 i = 0; i < set.Count(); ++i)
        {
            ActiveMasteryEntry const& e = set.entries[i];
            trans->Append(
                "INSERT INTO `character_mastery_loadout` (`guid`, `spec`, `school`, `tree`, `archetype`, "
                "`points_ppm`, `points_duration`, `points_magnitude`, `points_reach`) "
                "VALUES ({}, {}, {}, {}, {}, {}, {}, {}, {})",
                lowGuid, static_cast<uint32>(spec), static_cast<uint32>(e.school),
                static_cast<uint32>(e.tree), static_cast<uint32>(e.archetype),
                static_cast<uint32>(e.pointsPerAxis[static_cast<size_t>(ProcAxis::Ppm)]),
                static_cast<uint32>(e.pointsPerAxis[static_cast<size_t>(ProcAxis::Duration)]),
                static_cast<uint32>(e.pointsPerAxis[static_cast<size_t>(ProcAxis::Magnitude)]),
                static_cast<uint32>(e.pointsPerAxis[static_cast<size_t>(ProcAxis::Reach)]));
        }

        CharacterDatabase.CommitTransaction(trans);
    }

    void MasteryLoadoutMgr::LoadPlayer(Player* player)
    {
        // NOTE: blocking PK-indexed load on the login path, mirroring MasteryMgr/ProficiencyMgr. TODO:
        // move to the async WithCallback path once running under a full build.
        if (!_config.Enabled() || !player)
            return;

        LoadCharacterLoadout(player->GetGUID(), player->GetGUID().GetCounter());
        _activeSpec[player->GetGUID()] = player->GetActiveSpec();
    }

    void MasteryLoadoutMgr::SavePlayer(Player* player)
    {
        if (!_config.Enabled() || !player)
            return;

        auto it = _loadouts.find(player->GetGUID());
        if (it == _loadouts.end())
            return;

        // Persist every spec slot's collection so an unsaved swap target survives a relog.
        for (uint8_t spec = 0; spec < SpecSlots; ++spec)
            PersistSpec(player->GetGUID().GetCounter(), spec, it->second[spec]);
    }

    void MasteryLoadoutMgr::UnloadPlayer(ObjectGuid guid)
    {
        _loadouts.erase(guid);
        _activeSpec.erase(guid);
    }

    void MasteryLoadoutMgr::OnSpecChanged(Player* player, uint8_t newSpec)
    {
        // §14.11: a dual-spec switch loads the destination slot's SAVED set -- free, no token. The
        // cached collections already hold every slot; we only flip which one is live.
        if (!_config.Enabled() || !player || newSpec >= SpecSlots)
            return;

        _activeSpec[player->GetGUID()] = newSpec;
        LOG_DEBUG("module.branding", "Mastery loadout: {} swapped to spec slot {} (free)",
            player->GetGUID().ToString(), newSpec);
    }

    ActiveMasterySet const& MasteryLoadoutMgr::LoadoutForSpec(ObjectGuid charGuid, uint8_t spec) const
    {
        auto it = _loadouts.find(charGuid);
        if (it == _loadouts.end() || spec >= SpecSlots)
            return _empty;

        return it->second[spec];
    }

    ActiveMasterySet const& MasteryLoadoutMgr::ActiveLoadout(ObjectGuid charGuid) const
    {
        auto spec = _activeSpec.find(charGuid);
        uint8_t const slot = spec != _activeSpec.end() ? spec->second : 0;
        return LoadoutForSpec(charGuid, slot);
    }

    bool MasteryLoadoutMgr::IsValidFor(ObjectGuid charGuid, uint32_t accountId,
        ActiveMasterySet const& set) const
    {
        // Dual key per cell (§7.9/§14): the CURRENT account must have Brand Knowledge for the cell's
        // school (account-layer access, anti-P2W) AND the character must have earned a level in it.
        auto accountUnlocked = [accountId](BrandId school)
        {
            return sProficiencyMgr->IsBrandKnown(accountId, school);
        };
        auto schoolLevel = [charGuid](BrandId school) -> uint8_t
        {
            return sProficiencyMgr->BrandLevel(charGuid, school);
        };

        return IsActiveSetValid(set, accountUnlocked, schoolLevel, _config);
    }

    bool MasteryLoadoutMgr::Reallocate(Player* player, ActiveMasterySet const& set)
    {
        if (!_config.Enabled() || !player)
            return false;

        ObjectGuid const guid = player->GetGUID();
        uint32_t const accountId = player->GetSession()->GetAccountId();

        if (!IsValidFor(guid, accountId, set))
            return false;

        // §14.5/§14.11: re-allocating points costs the expensive token (spec switch would be free).
        uint32_t const cost = MasteryRespecCost(LoadoutChange::Reallocate, _config);
        if (cost > 0 && !player->HasEnoughMoney(static_cast<uint32>(cost)))
            return false;

        if (cost > 0)
            player->ModifyMoney(-static_cast<int32>(cost));

        SpecLoadouts& slots = _loadouts[guid];
        uint8_t const slot = player->GetActiveSpec() < SpecSlots ? player->GetActiveSpec() : 0;
        slots[slot] = set;
        _activeSpec[guid] = slot;
        PersistSpec(guid.GetCounter(), slot, set);

        LOG_INFO("module.branding", "Mastery loadout: {} re-allocated spec slot {} ({} cells), charged {}",
            guid.ToString(), slot, set.Count(), cost);
        return true;
    }
}

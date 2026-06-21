#include "LoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "DatabaseEnv.h"
#include "Player.h"
#include <cstddef>

namespace Branding
{
    LoadoutMgr* LoadoutMgr::instance()
    {
        static LoadoutMgr mgr;
        return &mgr;
    }

    void LoadoutMgr::LoadConfig()
    {
        _config.Load();
    }

    void LoadoutMgr::LoadPlayer(Player* player)
    {
        // NOTE: blocking PK lookup on the login path (tiny, mirrors ProficiencyMgr); async path TODO.
        if (!sProficiencyMgr->Config().Enabled() || !player)
            return;

        ObjectGuid const guid = player->GetGUID();
        BrandLoadout& loadout = _loadouts[guid];
        loadout = BrandLoadout{};

        QueryResult result = CharacterDatabase.Query(
            "SELECT `active_brand`, `proc_archetype` FROM `character_brand_loadout` WHERE `guid` = {}",
            guid.GetCounter());
        if (!result)
            return;

        Field* fields = result->Fetch();
        uint8 const brand = fields[0].Get<uint8>();
        if (brand < static_cast<uint8>(BrandId::COUNT))
            loadout.activeBrand = static_cast<BrandId>(brand);
        loadout.selectedProcArchetype = fields[1].Get<uint8>();
    }

    void LoadoutMgr::SavePlayer(Player* player)
    {
        if (!sProficiencyMgr->Config().Enabled() || !player)
            return;

        auto it = _loadouts.find(player->GetGUID());
        if (it == _loadouts.end())
            return;

        Persist(player->GetGUID().GetCounter(), it->second);
    }

    void LoadoutMgr::UnloadPlayer(ObjectGuid guid)
    {
        _loadouts.erase(guid);
    }

    BrandLoadout LoadoutMgr::GetLoadout(ObjectGuid charGuid) const
    {
        auto it = _loadouts.find(charGuid);
        return it != _loadouts.end() ? it->second : BrandLoadout{};
    }

    bool LoadoutMgr::IsValidFor(ObjectGuid charGuid, uint32_t accountId, BrandLoadout const& loadout) const
    {
        KnowledgeState const knowledge = sProficiencyMgr->AccountKnowledge(accountId);
        uint8_t const profLevel = sProficiencyMgr->BrandLevel(charGuid, loadout.activeBrand);
        return IsLoadoutValid(loadout, knowledge, profLevel, _config);
    }

    void LoadoutMgr::Persist(uint32_t lowGuid, BrandLoadout const& loadout) const
    {
        CharacterDatabase.Execute(
            "REPLACE INTO `character_brand_loadout` (`guid`, `active_brand`, `proc_archetype`) VALUES ({}, {}, {})",
            lowGuid, static_cast<uint32>(loadout.activeBrand), static_cast<uint32>(loadout.selectedProcArchetype));
    }

    bool LoadoutMgr::SetActiveBrand(Player* player, BrandId brand)
    {
        if (!player)
            return false;

        ObjectGuid const guid = player->GetGUID();
        uint32_t const accountId = player->GetSession()->GetAccountId();

        BrandLoadout candidate = GetLoadout(guid);
        candidate.activeBrand = brand;
        // Switching brand may invalidate the current archetype (different proficiency level); the
        // caller surfaces the rejection. Reset to the base archetype so a switch isn't blocked by a
        // stale high archetype the new brand's level can't express.
        candidate.selectedProcArchetype = 0;

        if (!IsValidFor(guid, accountId, candidate))
            return false;

        _loadouts[guid] = candidate;
        Persist(guid.GetCounter(), candidate);
        return true;
    }

    bool LoadoutMgr::SetArchetype(Player* player, uint8_t archetype)
    {
        if (!player)
            return false;

        ObjectGuid const guid = player->GetGUID();
        uint32_t const accountId = player->GetSession()->GetAccountId();

        BrandLoadout candidate = GetLoadout(guid);
        candidate.selectedProcArchetype = archetype;

        if (!IsValidFor(guid, accountId, candidate))
            return false;

        _loadouts[guid] = candidate;
        Persist(guid.GetCounter(), candidate);
        return true;
    }
}

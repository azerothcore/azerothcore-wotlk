#include "ProficiencyMgr.h"
#include "branding/proficiency/BrandXp.h"
#include "branding/proficiency/Knowledge.h"
#include "branding/proficiency/Proficiency.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Player.h"

namespace Branding
{
    ProficiencyMgr* ProficiencyMgr::instance()
    {
        static ProficiencyMgr mgr;
        return &mgr;
    }

    void ProficiencyMgr::LoadConfig()
    {
        _config.Load();
    }

    void ProficiencyMgr::LoadCharacterStates(ObjectGuid guid, uint32_t lowGuid)
    {
        BrandStates& states = _charStates[guid];
        states = BrandStates{};

        QueryResult result = CharacterDatabase.Query(
            "SELECT `brand`, `total_xp`, `recent_window`, `window_start` FROM `character_branding` WHERE `guid` = {}",
            lowGuid);
        if (!result)
            return;

        do
        {
            Field* fields = result->Fetch();
            uint8 const brand = fields[0].Get<uint8>();
            if (brand >= static_cast<uint8>(BrandId::COUNT))
                continue;

            ProficiencyState& state = states[brand];
            state.totalXp = fields[1].Get<uint64>();
            state.recentXpWindow = fields[2].Get<uint32>();
            state.windowStartUnix = fields[3].Get<uint32>();
        } while (result->NextRow());
    }

    void ProficiencyMgr::LoadAccountKnowledge(uint32_t accountId)
    {
        KnowledgeState& knowledge = _accountKnowledge[accountId];
        knowledge = KnowledgeState{};

        QueryResult result = LoginDatabase.Query(
            "SELECT `brand` FROM `account_brand_knowledge` WHERE `account` = {}", accountId);
        if (!result)
            return;

        do
        {
            uint8 const brand = result->Fetch()[0].Get<uint8>();
            if (brand < static_cast<uint8>(BrandId::COUNT))
                knowledge.unlockedMask |= (1u << brand);
        } while (result->NextRow());
    }

    KnowledgeState& ProficiencyMgr::EnsureAccountKnowledge(uint32_t accountId)
    {
        auto it = _accountKnowledge.find(accountId);
        if (it != _accountKnowledge.end())
            return it->second;

        LoadAccountKnowledge(accountId);
        return _accountKnowledge[accountId];
    }

    void ProficiencyMgr::LoadPlayer(Player* player)
    {
        // NOTE: loads run as blocking queries on the login path for simplicity. Both reads are tiny,
        // primary-key-indexed lookups. TODO: move to the async path (AsyncQuery + WithCallback via a
        // query processor) per §7.7 / project convention once running under a full build.
        if (!_config.Enabled() || !player)
            return;

        LoadCharacterStates(player->GetGUID(), player->GetGUID().GetCounter());
        LoadAccountKnowledge(player->GetSession()->GetAccountId());
    }

    void ProficiencyMgr::SavePlayer(Player* player)
    {
        if (!_config.Enabled() || !player)
            return;

        auto it = _charStates.find(player->GetGUID());
        if (it == _charStates.end())
            return;

        uint32 const lowGuid = player->GetGUID().GetCounter();
        for (size_t brand = 0; brand < it->second.size(); ++brand)
        {
            ProficiencyState const& state = it->second[brand];
            if (state.totalXp == 0 && state.windowStartUnix == 0)
                continue;

            CharacterDatabase.Execute(
                "REPLACE INTO `character_branding` (`guid`, `brand`, `total_xp`, `recent_window`, `window_start`) "
                "VALUES ({}, {}, {}, {}, {})",
                lowGuid, static_cast<uint32>(brand), state.totalXp, state.recentXpWindow,
                static_cast<uint32>(state.windowStartUnix));
        }
    }

    void ProficiencyMgr::UnloadPlayer(ObjectGuid guid)
    {
        _charStates.erase(guid);
    }

    XpResult ProficiencyMgr::ApplyActivity(ObjectGuid charGuid, uint32_t accountId, XpActivity const& activity)
    {
        BrandStates& states = _charStates[charGuid];
        KnowledgeState const& knowledge = _accountKnowledge[accountId];

        ProficiencyState& state = states[static_cast<size_t>(activity.activeBrand)];
        return Branding::ApplyActivity(state, activity, knowledge, _config, _clock);
    }

    double ProficiencyMgr::EffectStrength(ObjectGuid charGuid, uint32_t accountId, BrandId brand) const
    {
        auto charIt = _charStates.find(charGuid);
        if (charIt == _charStates.end())
            return 0.0;

        auto accIt = _accountKnowledge.find(accountId);
        KnowledgeState const knowledge = accIt != _accountKnowledge.end() ? accIt->second : KnowledgeState{};

        ProficiencyState const& state = charIt->second[static_cast<size_t>(brand)];
        uint8_t const level = LevelForXp(state.totalXp, _config);
        return ResolvedEffectStrength(level, brand, knowledge, _config);
    }

    uint8_t ProficiencyMgr::BrandLevel(ObjectGuid charGuid, BrandId brand) const
    {
        auto it = _charStates.find(charGuid);
        if (it == _charStates.end())
            return 0;

        return LevelForXp(it->second[static_cast<size_t>(brand)].totalXp, _config);
    }

    LevelProgress ProficiencyMgr::BrandProgress(ObjectGuid charGuid, BrandId brand) const
    {
        auto it = _charStates.find(charGuid);
        if (it == _charStates.end())
            return ComputeLevelProgress(0, _config);

        return ComputeLevelProgress(it->second[static_cast<size_t>(brand)].totalXp, _config);
    }

    bool ProficiencyMgr::UnlockBrand(uint32_t accountId, BrandId brand)
    {
        if (brand >= BrandId::COUNT)
            return false;

        // Refresh the in-memory mask first (pure-core mutation) so earning works immediately for any
        // currently logged-in character on this account; only persist when it is a new unlock.
        KnowledgeState& knowledge = EnsureAccountKnowledge(accountId);
        if (!Branding::UnlockBrand(brand, knowledge))
            return false;

        LoginDatabase.Execute(
            "REPLACE INTO `account_brand_knowledge` (`account`, `brand`, `unlocked_at`) "
            "VALUES ({}, {}, UNIX_TIMESTAMP())",
            accountId, static_cast<uint32>(brand));

        LOG_INFO("module.branding", "Brand knowledge unlocked: account {} brand {}.",
            accountId, static_cast<uint32>(brand));
        return true;
    }

    bool ProficiencyMgr::IsBrandKnown(uint32_t accountId, BrandId brand)
    {
        return CanEarnProficiency(brand, EnsureAccountKnowledge(accountId));
    }

    uint32_t ProficiencyMgr::KnowledgeMask(uint32_t accountId)
    {
        return EnsureAccountKnowledge(accountId).unlockedMask;
    }

    KnowledgeState ProficiencyMgr::AccountKnowledge(uint32_t accountId) const
    {
        auto it = _accountKnowledge.find(accountId);
        return it != _accountKnowledge.end() ? it->second : KnowledgeState{};
    }
}

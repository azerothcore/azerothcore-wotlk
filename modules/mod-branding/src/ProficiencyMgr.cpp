#include "ProficiencyMgr.h"
#include "branding/proficiency/BrandXp.h"
#include "branding/proficiency/Knowledge.h"
#include "branding/proficiency/Proficiency.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Player.h"
#include <algorithm>

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
        {
            RefreshTopLevel(guid);
            return;
        }

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

        RefreshTopLevel(guid);
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

    void ProficiencyMgr::LoadAccountMaxedBrands(uint32_t accountId)
    {
        uint8_t& count = _accountMaxedBrands[accountId];
        count = 0;

        // Best (highest total_xp) per brand across every character on the account -- a brand is
        // "maxed" on the account if any one character has graduated it (§7.11 standing input).
        QueryResult result = CharacterDatabase.Query(
            "SELECT cb.`brand`, MAX(cb.`total_xp`) FROM `character_branding` cb "
            "JOIN `characters` c ON c.`guid` = cb.`guid` WHERE c.`account` = {} GROUP BY cb.`brand`",
            accountId);
        if (!result)
            return;

        do
        {
            Field* fields = result->Fetch();
            uint8 const brand = fields[0].Get<uint8>();
            if (brand >= static_cast<uint8>(BrandId::COUNT))
                continue;

            if (LevelForXp(fields[1].Get<uint64>(), _config) >= _config.MaxLevel())
                ++count;
        } while (result->NextRow());
    }

    uint8_t ProficiencyMgr::AccountMaxedBrandCount(uint32_t accountId)
    {
        auto it = _accountMaxedBrands.find(accountId);
        if (it != _accountMaxedBrands.end())
            return it->second;

        LoadAccountMaxedBrands(accountId);
        return _accountMaxedBrands[accountId];
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

        uint32 const account = player->GetSession()->GetAccountId();
        LoadCharacterStates(player->GetGUID(), player->GetGUID().GetCounter());
        LoadAccountKnowledge(account);
        LoadAccountMaxedBrands(account);
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
        _topLevel.erase(guid);
    }

    XpResult ProficiencyMgr::ApplyActivity(ObjectGuid charGuid, uint32_t accountId, XpActivity const& activity)
    {
        BrandStates& states = _charStates[charGuid];
        KnowledgeState const& knowledge = _accountKnowledge[accountId];

        ProficiencyState& state = states[static_cast<size_t>(activity.activeBrand)];
        XpResult const result = Branding::ApplyActivity(state, activity, knowledge, _config, _clock);

        // A fresh graduation changes the account's §7.11 standing; drop the cache so it recomputes.
        if (result.reachedPrestige)
            _accountMaxedBrands.erase(accountId);

        RefreshTopLevel(charGuid);   // keep the §2.7 top-level cache current after an XP gain
        return result;
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

    uint8_t ProficiencyMgr::TopBrandLevel(ObjectGuid charGuid) const
    {
        auto it = _topLevel.find(charGuid);
        return it != _topLevel.end() ? it->second : uint8_t{0};
    }

    void ProficiencyMgr::RefreshTopLevel(ObjectGuid charGuid)
    {
        auto it = _charStates.find(charGuid);
        if (it == _charStates.end())
        {
            _topLevel.erase(charGuid);
            return;
        }

        uint8_t top = 0;
        for (ProficiencyState const& state : it->second)
            top = std::max(top, LevelForXp(state.totalXp, _config));

        _topLevel[charGuid] = top;
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

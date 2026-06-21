#include "MasteryMgr.h"
#include "DatabaseEnv.h"
#include "Player.h"

namespace Branding
{
    MasteryMgr* MasteryMgr::instance()
    {
        static MasteryMgr mgr;
        return &mgr;
    }

    void MasteryMgr::LoadConfig()
    {
        _config.Load();
    }

    void MasteryMgr::LoadCharacterMastery(ObjectGuid guid, uint32_t lowGuid)
    {
        LevelArray& levels = _charLevels[guid];
        levels = LevelArray{};

        // character_mastery: the per-character EARNED skill layer (one of the two dual keys, §14).
        QueryResult result = CharacterDatabase.Query(
            "SELECT `mastery_id`, `level` FROM `character_mastery` WHERE `guid` = {}", lowGuid);
        if (!result)
            return;

        do
        {
            Field* fields = result->Fetch();
            uint8 const masteryId = fields[0].Get<uint8>();
            if (masteryId >= static_cast<uint8>(MasterySystem::COUNT))
                continue;

            levels[masteryId] = fields[1].Get<uint8>();
        } while (result->NextRow());
    }

    void MasteryMgr::LoadAccountMastery(uint32_t accountId)
    {
        UnlockArray& unlocks = _accountUnlocks[accountId];
        unlocks = UnlockArray{};

        // account_mastery: the account-wide UNLOCK layer (the other dual key, §14). Account-scoped
        // so it gates expression on whichever account currently owns the character (anti-P2W).
        QueryResult result = LoginDatabase.Query(
            "SELECT `mastery_id` FROM `account_mastery` WHERE `account` = {} AND `unlocked` = 1", accountId);
        if (!result)
            return;

        do
        {
            uint8 const masteryId = result->Fetch()[0].Get<uint8>();
            if (masteryId < static_cast<uint8>(MasterySystem::COUNT))
                unlocks[masteryId] = true;
        } while (result->NextRow());
    }

    void MasteryMgr::LoadPlayer(Player* player)
    {
        // NOTE: loads run as blocking queries on the login path for simplicity (mirrors
        // ProficiencyMgr). Both reads are tiny, primary-key-indexed lookups. TODO: move to the async
        // path (AsyncQuery + WithCallback) once running under a full build.
        if (!_config.Enabled() || !player)
            return;

        LoadCharacterMastery(player->GetGUID(), player->GetGUID().GetCounter());
        LoadAccountMastery(player->GetSession()->GetAccountId());
    }

    void MasteryMgr::SavePlayer(Player* player)
    {
        if (!_config.Enabled() || !player)
            return;

        auto it = _charLevels.find(player->GetGUID());
        if (it == _charLevels.end())
            return;

        uint32 const lowGuid = player->GetGUID().GetCounter();
        for (size_t mastery = 0; mastery < it->second.size(); ++mastery)
        {
            uint8 const level = it->second[mastery];
            if (level == 0)
                continue;

            CharacterDatabase.Execute(
                "REPLACE INTO `character_mastery` (`guid`, `mastery_id`, `level`) VALUES ({}, {}, {})",
                lowGuid, static_cast<uint32>(mastery), static_cast<uint32>(level));
        }
    }

    void MasteryMgr::UnloadPlayer(ObjectGuid guid)
    {
        _charLevels.erase(guid);
    }

    double MasteryMgr::Effectiveness(ObjectGuid charGuid, uint32_t accountId, MasterySystem system) const
    {
        return MasteryEffectiveness(AccountUnlocked(accountId, system), MasteryLevel(charGuid, system), _config);
    }

    double MasteryMgr::Bonus(ObjectGuid charGuid, uint32_t accountId, MasterySystem system) const
    {
        return MasteryBonus(AccountUnlocked(accountId, system), MasteryLevel(charGuid, system), _config);
    }

    uint8_t MasteryMgr::MasteryLevel(ObjectGuid charGuid, MasterySystem system) const
    {
        auto it = _charLevels.find(charGuid);
        if (it == _charLevels.end())
            return 0;

        return it->second[static_cast<size_t>(system)];
    }

    bool MasteryMgr::AccountUnlocked(uint32_t accountId, MasterySystem system) const
    {
        auto it = _accountUnlocks.find(accountId);
        if (it == _accountUnlocks.end())
            return false;

        return it->second[static_cast<size_t>(system)];
    }
}

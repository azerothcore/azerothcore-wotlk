#ifndef MOD_BRANDING_SRC_MASTERYMGR_H
#define MOD_BRANDING_SRC_MASTERYMGR_H

#include "MasteryConfig.h"
#include "mastery/Mastery.h"
#include "ObjectGuid.h"
#include <array>
#include <cstddef>
#include <unordered_map>

class Player;

namespace Branding
{
    // Adapter manager for the §14 mastery dual-key. Owns the per-account unlock cache and the
    // per-character earned-level cache, translates live game state into pure-core calls, and
    // persists both layers. No Player*/Creature* is stored past a call -- the character cache is
    // keyed by ObjectGuid and the account cache by accountId (project long-lived-reference rule).
    class MasteryMgr
    {
    public:
        static MasteryMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }
        MasteryConfig const& Config() const { return _config; }

        // Login/logout lifecycle.
        void LoadPlayer(Player* player);
        void SavePlayer(Player* player);
        void UnloadPlayer(ObjectGuid guid);

        // Dual-key effectiveness in [0, 1] for a mastery on the character's current account.
        double Effectiveness(ObjectGuid charGuid, uint32_t accountId, MasterySystem system) const;

        // Observable consumer value: bounded fractional bonus (0 if either key missing).
        double Bonus(ObjectGuid charGuid, uint32_t accountId, MasterySystem system) const;

        // Cached earned level for a mastery (0 if the character isn't loaded). For inspection.
        uint8_t MasteryLevel(ObjectGuid charGuid, MasterySystem system) const;

        // Whether the account has unlocked a mastery (false if not loaded). For inspection.
        bool AccountUnlocked(uint32_t accountId, MasterySystem system) const;

    private:
        MasteryMgr() = default;

        using LevelArray = std::array<uint8_t, static_cast<size_t>(MasterySystem::COUNT)>;
        using UnlockArray = std::array<bool, static_cast<size_t>(MasterySystem::COUNT)>;

        void LoadCharacterMastery(ObjectGuid guid, uint32_t lowGuid);
        void LoadAccountMastery(uint32_t accountId);

        MasteryConfig _config;
        std::unordered_map<ObjectGuid, LevelArray> _charLevels;
        std::unordered_map<uint32_t, UnlockArray> _accountUnlocks;
    };
}

#define sMasteryMgr Branding::MasteryMgr::instance()

#endif // MOD_BRANDING_SRC_MASTERYMGR_H

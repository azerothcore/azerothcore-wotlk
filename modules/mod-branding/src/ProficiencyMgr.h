#ifndef MOD_BRANDING_SRC_PROFICIENCYMGR_H
#define MOD_BRANDING_SRC_PROFICIENCYMGR_H

#include "BrandingConfig.h"
#include "ServerClock.h"
#include "proficiency/Types.h"
#include "ObjectGuid.h"
#include <array>
#include <cstddef>
#include <unordered_map>

class Player;
class Creature;

namespace Branding
{
    // Adapter manager: owns the per-character proficiency cache and per-account knowledge cache,
    // translates live game state into pure-core calls, and persists results. No Player*/Creature*
    // is stored past a call -- the cache is keyed by ObjectGuid (project long-lived-reference rule).
    class ProficiencyMgr
    {
    public:
        static ProficiencyMgr* instance();

        void LoadConfig();
        BrandingConfig const& Config() const { return _config; }

        // Login/logout lifecycle.
        void LoadPlayer(Player* player);
        void SavePlayer(Player* player);
        void UnloadPlayer(ObjectGuid guid);

        // Grants XP for an activity, persisting nothing immediately (flushed on logout/periodic).
        XpResult ApplyActivity(ObjectGuid charGuid, uint32_t accountId, XpActivity const& activity);

        // Resolved, anti-P2W effect strength for a brand on the character's current account.
        double EffectStrength(ObjectGuid charGuid, uint32_t accountId, BrandId brand) const;

        // Cached proficiency level for a brand (0 if the character isn't loaded). For inspection.
        uint8_t BrandLevel(ObjectGuid charGuid, BrandId brand) const;

        // Knowledge unlock flow (design §6). Persists the row to `account_brand_knowledge` and
        // refreshes the in-memory account mask so earning works immediately. Returns true iff this
        // was a new unlock (false if already known). Loads the account's knowledge on demand if it
        // is not yet cached (e.g. granting an offline account is still consistent on next login).
        bool UnlockBrand(uint32_t accountId, BrandId brand);

        // Is this brand currently unlocked for the account? Loads on demand if not cached.
        bool IsBrandKnown(uint32_t accountId, BrandId brand);

        // The account's full knowledge mask (loaded on demand). For the `knowledge list` command.
        uint32_t KnowledgeMask(uint32_t accountId);

        // Cached account knowledge (empty state if the account isn't loaded). Lets LoadoutMgr
        // validate brand selection against account-wide unlocks without a second DB read.
        KnowledgeState AccountKnowledge(uint32_t accountId) const;

    private:
        ProficiencyMgr() = default;

        using BrandStates = std::array<ProficiencyState, static_cast<size_t>(BrandId::COUNT)>;

        void LoadCharacterStates(ObjectGuid guid, uint32_t lowGuid);
        void LoadAccountKnowledge(uint32_t accountId);

        // Returns the cached knowledge for an account, loading it from the DB if not yet present.
        KnowledgeState& EnsureAccountKnowledge(uint32_t accountId);

        BrandingConfig _config;
        ServerClock _clock;
        std::unordered_map<ObjectGuid, BrandStates> _charStates;
        std::unordered_map<uint32_t, KnowledgeState> _accountKnowledge;
    };
}

#define sProficiencyMgr Branding::ProficiencyMgr::instance()

#endif // MOD_BRANDING_SRC_PROFICIENCYMGR_H

#ifndef MOD_BRANDING_SRC_PROFICIENCYMGR_H
#define MOD_BRANDING_SRC_PROFICIENCYMGR_H

#include "BrandingConfig.h"
#include "ServerClock.h"
#include "branding/proficiency/Proficiency.h"
#include "branding/proficiency/Types.h"
#include "branding/scaling/GroupScaling.h"
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

        // Per-kill Proficiency baseUnits (§7.4, issue #32): the "as if at-level" worth (level-diff
        // penalty stripped via Acore::XP::BaseGain) scaled by the kill's con-color difficulty band
        // and the creature's classification. Con-independent -- a grey/over-levelled kill still pays
        // the floored amount, so proficiency is earnable anywhere. The AzerothCore glue (levels,
        // zone content tier, color band, elite/rare/boss classification) lives here; the sizing
        // formula itself is the pure Branding::KillBaseUnits. Neither pointer is stored.
        uint32_t KillBaseUnits(Player const* killer, Creature const* killed) const;

        // Resolved, anti-P2W effect strength for a brand on the character's current account.
        double EffectStrength(ObjectGuid charGuid, uint32_t accountId, BrandId brand) const;

        // Cached proficiency level for a brand (0 if the character isn't loaded). For inspection.
        uint8_t BrandLevel(ObjectGuid charGuid, BrandId brand) const;

        // The character's overall branding "rank": highest proficiency level across all brands
        // (0 if the character isn't loaded). Drives the §2.7 rank-based drop bonus (issue #81).
        // O(1): reads a cached value refreshed on load/XP-gain (the loot-roll path calls this per
        // dropped item, so recomputing the per-brand level curve each time would be wasteful).
        uint8_t TopBrandLevel(ObjectGuid charGuid) const;

        // §2.7 Branding Boon (issue #83): the raid-wide economy axis this character has selected
        // (BoonAxis::None if the character isn't loaded or hasn't chosen). Cached; loaded on login.
        BoonAxis SelectedBoon(ObjectGuid charGuid) const;

        // Persist a new boon selection for a loaded character (cache + `character_branding_boon`).
        // The expensive re-select cost is charged by the caller (command/vendor); this only stores
        // the choice. No-op if the character isn't loaded.
        void SetSelectedBoon(ObjectGuid charGuid, BoonAxis axis);

        // XP-bar progression for a brand on this character (issue #54): level + position within it.
        // Zeroed (level 0, no span) if the character isn't loaded. Pure decomposition over §7.4.
        LevelProgress BrandProgress(ObjectGuid charGuid, BrandId brand) const;

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

        // §7.11 leveling-scoped branding (issue #77): the account's "standing" input -- how many brands
        // any character on the account has taken to max proficiency. Loaded on demand and cached per
        // account (a single aggregation over the account's characters). Feeds AccountBrandStanding.
        uint8_t AccountMaxedBrandCount(uint32_t accountId);

    private:
        ProficiencyMgr() = default;

        using BrandStates = std::array<ProficiencyState, static_cast<size_t>(BrandId::COUNT)>;

        void LoadCharacterStates(ObjectGuid guid, uint32_t lowGuid);
        void LoadAccountKnowledge(uint32_t accountId);
        void LoadAccountMaxedBrands(uint32_t accountId);
        void LoadBoonSelection(ObjectGuid guid, uint32_t lowGuid);

        // Returns the cached knowledge for an account, loading it from the DB if not yet present.
        KnowledgeState& EnsureAccountKnowledge(uint32_t accountId);

        // Recompute and cache the character's highest per-brand level. Called at the three sites that
        // mutate _charStates (load, apply-activity, unload) so TopBrandLevel stays O(1) and current.
        void RefreshTopLevel(ObjectGuid charGuid);

        BrandingConfig _config;
        ServerClock _clock;
        std::unordered_map<ObjectGuid, BrandStates> _charStates;
        std::unordered_map<uint32_t, KnowledgeState> _accountKnowledge;
        std::unordered_map<uint32_t, uint8_t> _accountMaxedBrands;
        std::unordered_map<ObjectGuid, uint8_t> _topLevel;   // derived cache for TopBrandLevel (§2.7)
        std::unordered_map<ObjectGuid, BoonAxis> _boon;      // per-character selected boon axis (§2.7/#83)
    };
}

#define sProficiencyMgr Branding::ProficiencyMgr::instance()

#endif // MOD_BRANDING_SRC_PROFICIENCYMGR_H

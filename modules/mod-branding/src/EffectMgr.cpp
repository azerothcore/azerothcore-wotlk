#include "EffectMgr.h"
#include "BrandRole.h"
#include "EventMgr.h"
#include "LoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "branding/contribution/ContributionTypes.h"
#include "branding/proficiency/Knowledge.h"
#include "Configuration/Config.h"
#include "GameTime.h"
#include "Map.h"
#include "Player.h"
#include <algorithm>
#include <bit>

namespace Branding
{
    namespace
    {
        uint64_t NowMs()
        {
            return static_cast<uint64_t>(GameTime::GetGameTimeMS().count());
        }
    }

    EffectMgr* EffectMgr::instance()
    {
        static EffectMgr mgr;
        return &mgr;
    }

    void EffectMgr::LoadConfig()
    {
        _config.Load();
        // The absorb costume for the overheal transform. Default Power Word: Shield (48066); a clean
        // basepoint-driven SCHOOL_ABSORB id can be substituted via config (see #30 spell-costume work).
        _overhealShieldSpell = sConfigMgr->GetOption<uint32>("Branding.Effect.OverhealShieldSpell", 48066);
    }

    bool EffectMgr::Resolve(Player* player, EffectProfile& profile, uint8_t& level) const
    {
        if (!_config.Enabled() || !player)
            return false;

        ObjectGuid const guid = player->GetGUID();
        uint32 const account = player->GetSession()->GetAccountId();
        BrandId const brand = sLoadoutMgr->GetLoadout(guid).activeBrand;

        // Anti-P2W (§1/§7.5): inert unless the CURRENT account can express the brand.
        if (!CanExpressBrand(brand, sProficiencyMgr->AccountKnowledge(account)))
            return false;

        profile = ProfileFor(brand, DetectRole(player));
        level = sProficiencyMgr->BrandLevel(guid, brand);
        return true;
    }

    LevelingContext EffectMgr::LevelingContextFor(Player* player) const
    {
        if (!player)
            return LevelingContext::None;

        // Instanced dungeon takes precedence; otherwise an active invasion in the player's zone.
        Map* map = player->GetMap();
        if (map && map->IsDungeon())
            return LevelingContext::Dungeon;

        EventType type = EventType::Invasion;
        if (sEventMgr->ActiveEventType(player->GetZoneId(), type) && type == EventType::Invasion)
            return LevelingContext::Invasion;

        return LevelingContext::None;
    }

    AccountBrandStanding EffectMgr::StandingFor(Player* player) const
    {
        AccountBrandStanding standing;
        if (!player)
            return standing;

        uint32 const account = player->GetSession()->GetAccountId();
        standing.maxedBrands = sProficiencyMgr->AccountMaxedBrandCount(account);
        standing.knowledgeTier = static_cast<uint8_t>(std::popcount(sProficiencyMgr->KnowledgeMask(account)));
        return standing;
    }

    double EffectMgr::LevelingMultiplierFor(Player* player) const
    {
        if (!player)
            return 1.0;

        LevelingContext const ctx = LevelingContextFor(player);
        if (ctx == LevelingContext::None)
            return 1.0;

        // Account-keyed budget; the core enforces the cap and the ding-to-cap boundary (§7.11).
        return LevelingMultiplier(player->GetLevel(), ctx, StandingFor(player), _config);
    }

    double EffectMgr::OutgoingMultiplierFor(Player* attacker) const
    {
        EffectProfile profile;
        uint8_t level = 0;
        if (!Resolve(attacker, profile, level))
            return 1.0;

        // v1 catalyst stack weight = 1.0 (full); the cross-raid roster weight is the issue #04 seam.
        // §7.11: the leveling budget multiplies the (near-1.0 while leveling) earned expression.
        return WindowedOutgoingMultiplier(profile, level, 1.0, NowMs(), _config) * LevelingMultiplierFor(attacker);
    }

    double EffectMgr::IncomingDamageMultiplierFor(Player* victim) const
    {
        EffectProfile profile;
        uint8_t level = 0;
        if (!Resolve(victim, profile, level))
            return 1.0;

        // §7.11: the leveling budget reduces incoming damage (survivability) -- its inverse, clamped
        // to (0, 1]. A leveling character earns ~1.0 from the window path, so the budget is the driver.
        double const base = WindowedIncomingMultiplier(profile, level, NowMs(), _config);
        double const leveling = LevelingMultiplierFor(victim);
        return leveling > 0.0 ? std::min(1.0, base / leveling) : base;
    }

    uint32_t EffectMgr::OverhealShieldFor(Player* healer, Unit* target, uint32_t heal) const
    {
        EffectProfile profile;
        uint8_t level = 0;
        if (!target || !Resolve(healer, profile, level))
            return 0;

        // Only the healer MechanicTransform expresses as a shield (structural, always-on by kind).
        if (profile.kind != EffectKind::MechanicTransform)
            return 0;

        // §7.11: while leveling in a qualifying context (and if transforms are granted), lift the
        // effective strength from the account budget so the transform actually expresses -- a fresh
        // alt has ~0 earned proficiency. Maps the budget fraction onto the proficiency scale. At max
        // level LevelingMultiplierFor() is 1.0, so this reduces to the earned level (endgame intact).
        uint8_t effLevel = level;
        LevelingContext const ctx = LevelingContextFor(healer);
        if (LevelingGrantsTransforms(ctx, _config))
        {
            double const span = _config.MaxLevelingMul() - 1.0;
            double const frac = span > 0.0 ? (LevelingMultiplierFor(healer) - 1.0) / span : 0.0;
            uint8_t const levelingLevel = static_cast<uint8_t>(frac * _config.MaxEffectLevel());
            effLevel = std::max(level, levelingLevel);
        }

        uint32 const maxHealth = target->GetMaxHealth();
        uint32 const curHealth = target->GetHealth();
        uint32 const missing = maxHealth > curHealth ? maxHealth - curHealth : 0u;
        return OverhealShieldAmount(heal, missing, maxHealth, effLevel, _config);
    }

    bool EffectMgr::ResolveActiveProfile(Player* player, EffectProfile& profile, uint8_t& level) const
    {
        return Resolve(player, profile, level);
    }
}

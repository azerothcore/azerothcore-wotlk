#include "Heroic.h"

namespace Branding
{
    bool HeroicOverlayEngages(HeroicContext const& ctx)
    {
        // Supply overlay tuning only when heroic is selected AND the engine has no native heroic for
        // this map -- otherwise the engine already tuned the content (§2.4.1, never double-scale).
        return ctx.selected == SelectedDifficulty::Heroic && !ctx.nativeHeroicMap;
    }

    double HeroicHealthMul(HeroicContext const& ctx, IHeroicConfig const& cfg)
    {
        return HeroicOverlayEngages(ctx) ? cfg.HeroicHealthMul() : 1.0;
    }

    double HeroicDamageMul(HeroicContext const& ctx, IHeroicConfig const& cfg)
    {
        return HeroicOverlayEngages(ctx) ? cfg.HeroicDamageMul() : 1.0;
    }

    uint8_t HeroicLevelTarget(HeroicContext const& ctx, IHeroicConfig const& /*cfg*/)
    {
        return HeroicOverlayEngages(ctx) ? ctx.maxLevel : uint8_t(0);
    }

    uint8_t HeroicTierBonus(HeroicContext const& ctx, IHeroicConfig const& cfg)
    {
        // Applies whenever the run is heroic (native or overlay) -- it bumps the branding reward tier,
        // independent of who tuned the encounter stats.
        return ctx.selected == SelectedDifficulty::Heroic ? cfg.HeroicTierBonus() : uint8_t(0);
    }
}

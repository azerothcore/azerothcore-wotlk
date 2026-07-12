#include "ScalingConfig.h"
#include "Configuration/Config.h"
#include <algorithm>
#include <limits>

namespace Branding
{
    void ScalingConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Scaling.Enable", false);
        _exponent = sConfigMgr->GetOption<float>("Branding.Scaling.Exponent", 2.0f);

        // Group-scaling dials (reserved for the future group-scaling adapter).
        _groupHealthFloor = sConfigMgr->GetOption<float>("Branding.Scaling.GroupHealthFloor", 0.3f);
        _groupDamageFloor = sConfigMgr->GetOption<float>("Branding.Scaling.GroupDamageFloor", 0.6f);
        _maxGroupMaterials = sConfigMgr->GetOption<uint32_t>("Branding.Scaling.MaxGroupMaterials", 20);
        _maxRewardTier = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Scaling.MaxRewardTier", 4));
        _rareChanceMulMin = sConfigMgr->GetOption<float>("Branding.Scaling.RareChanceMulMin", 0.5f);
        _rareChanceMulMax = sConfigMgr->GetOption<float>("Branding.Scaling.RareChanceMulMax", 2.0f);

        // Branding-currency reduction (§2.4.3): currency falls off steeper than gear.
        _currencyReductionExponent = sConfigMgr->GetOption<float>("Branding.Scaling.CurrencyReductionExponent", 2.0f);
        _currencyMulFloor = sConfigMgr->GetOption<float>("Branding.Scaling.CurrencyMulFloor", 0.05f);

        // Branding Boon (§2.7, issues #81/#83): selectable raid-wide economy rate (Drop/Xp/Gold).
        _boonEnabled = sConfigMgr->GetOption<bool>("Branding.Boon.Enable", false);
        // Clamp to INT32_MAX: the cost is charged via Player::ModifyMoney(int32), so a larger value
        // would wrap negative and REFUND the player instead of charging. (INT32_MAX copper ~= 214k
        // gold is already an absurd re-select price, so the clamp never bites a sane config.)
        _boonReselectCost = std::min<uint32_t>(sConfigMgr->GetOption<uint32_t>("Branding.Boon.ReselectCost", 1000000),
            static_cast<uint32_t>(std::numeric_limits<int32_t>::max()));
        _boonDropCap = sConfigMgr->GetOption<float>("Branding.Boon.DropCap", 1.5f);
        _boonXpCap = sConfigMgr->GetOption<float>("Branding.Boon.XpCap", 1.5f);
        _boonGoldCap = sConfigMgr->GetOption<float>("Branding.Boon.GoldCap", 1.5f);
        // Same harsh DR as the §7.9 catalyst: default to the shared Branding.Catalyst.StackDecay.
        _boonStackDecay = sConfigMgr->GetOption<float>("Branding.Boon.StackDecay",
            sConfigMgr->GetOption<float>("Branding.Catalyst.StackDecay", 0.4f));
        // Rank->strength normalization ceiling = the §7 proficiency MaxLevel (Branding.Level.Max).
        _boonMaxRank = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Level.Max", 50));
    }
}

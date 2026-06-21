#include "ItemBrandConfig.h"
#include "Configuration/Config.h"
#include <algorithm>

namespace Branding
{
    void ItemBrandConfig::Load()
    {
        _levelsPerStep = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Item.LevelsPerStep", 8));
        _maxStep = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Item.MaxStep", 3));
        _baseIntensity = sConfigMgr->GetOption<float>("Branding.Item.BaseIntensity", 1.0f);
        _intensityPerLevel = sConfigMgr->GetOption<float>("Branding.Item.IntensityPerLevel", 0.05f);
        _upgradeCostPerLevel = sConfigMgr->GetOption<uint32_t>("Branding.Item.UpgradeCostPerLevel", 100);
        _accountKnowledgeCost = sConfigMgr->GetOption<uint32_t>("Branding.Item.AccountKnowledgeCost", 100000);

        _baseArchetypes = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Loadout.BaseArchetypes", 1));
        _archetypeLevelStep = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Loadout.ArchetypeLevelStep", 10));
        _maxArchetypes = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Loadout.MaxArchetypes", 6));
    }

    uint8_t ItemBrandConfig::ArchetypesAtLevel(uint8_t profLevel) const
    {
        if (_archetypeLevelStep == 0)
            return _maxArchetypes;

        uint32_t const unlocked = static_cast<uint32_t>(_baseArchetypes) + profLevel / _archetypeLevelStep;
        return static_cast<uint8_t>(std::min<uint32_t>(unlocked, _maxArchetypes));
    }
}

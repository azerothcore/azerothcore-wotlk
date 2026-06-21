#include "MasteryConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void MasteryConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Mastery.Enable", false);
        _maxLevel = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Mastery.MaxLevel", 50));
        _maxBonus = sConfigMgr->GetOption<float>("Branding.Mastery.MaxBonus", 0.20f);

        // §14.10 combat-tree tunables (player-tuning knob = module config).
        _maxUptime = sConfigMgr->GetOption<float>("Branding.Mastery.Tree.MaxUptime", 0.60f);
        _upkeepHalfLevel = sConfigMgr->GetOption<float>("Branding.Mastery.Tree.UpkeepHalfLevel", 25.0f);
        _offSchoolFactor = sConfigMgr->GetOption<float>("Branding.Mastery.Tree.OffSchoolFactor", 0.25f);
        _maxEnemyMul = sConfigMgr->GetOption<float>("Branding.Mastery.Tree.MaxEnemyMul", 1.5f);
        _minPpm = sConfigMgr->GetOption<float>("Branding.Mastery.Tree.MinPpm", 1.0f);
        _maxPpm = sConfigMgr->GetOption<float>("Branding.Mastery.Tree.MaxPpm", 10.0f);
        _minWindowMs = sConfigMgr->GetOption<uint32_t>("Branding.Mastery.Tree.MinWindowMs", 3000);
        _maxWindowMs = sConfigMgr->GetOption<uint32_t>("Branding.Mastery.Tree.MaxWindowMs", 12000);
        _maxProcMagnitude = sConfigMgr->GetOption<float>("Branding.Mastery.Tree.MaxProcMagnitude", 2.0f);
        _minReach = sConfigMgr->GetOption<float>("Branding.Mastery.Tree.MinReach", 0.0f);
        _maxReach = sConfigMgr->GetOption<float>("Branding.Mastery.Tree.MaxReach", 40.0f);
        _archetypeUnlockStep = sConfigMgr->GetOption<uint32_t>("Branding.Mastery.Tree.ArchetypeUnlockStep", 20);

        // §14.10/§14.11 per-spec loadout tunables (point-buy budget, respec token, active-cell cap).
        _pointsBudget = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Mastery.PointsBudget", 10));
        _respecCost = sConfigMgr->GetOption<uint32_t>("Branding.Mastery.RespecCost", 500);
        _maxActive = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Mastery.MaxActive", 1));
        _maxArchetypes = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Mastery.MaxArchetypesPerCell", 3));
    }
}

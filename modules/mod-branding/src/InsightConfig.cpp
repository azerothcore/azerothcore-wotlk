#include "InsightConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void InsightConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Insight.Enable", false);

        _base[static_cast<size_t>(SourceRank::RaidBoss)] =
            sConfigMgr->GetOption<float>("Branding.Insight.RaidBossBase", 1.0f);
        _base[static_cast<size_t>(SourceRank::DungeonBossHeroic)] =
            sConfigMgr->GetOption<float>("Branding.Insight.DungeonHeroicBase", 0.5f);
        _base[static_cast<size_t>(SourceRank::DungeonBossNormal)] =
            sConfigMgr->GetOption<float>("Branding.Insight.DungeonNormalBase", 0.25f);
        _base[static_cast<size_t>(SourceRank::TrashMote)] =
            sConfigMgr->GetOption<float>("Branding.Insight.MoteBase", 0.01f);

        _drFactor[static_cast<size_t>(SourceRank::RaidBoss)] = 1.0;   // not windowed; lockout throttles
        _drFactor[static_cast<size_t>(SourceRank::DungeonBossHeroic)] =
            sConfigMgr->GetOption<float>("Branding.Insight.DungeonDrFactor", 0.5f);
        _drFactor[static_cast<size_t>(SourceRank::DungeonBossNormal)] =
            sConfigMgr->GetOption<float>("Branding.Insight.DungeonDrFactor", 0.5f);
        _drFactor[static_cast<size_t>(SourceRank::TrashMote)] =
            sConfigMgr->GetOption<float>("Branding.Insight.MoteDrFactor", 0.5f);

        _windowSeconds = sConfigMgr->GetOption<uint32_t>("Branding.Insight.WindowSeconds", 3600);
        _unlockThreshold = sConfigMgr->GetOption<float>("Branding.Insight.UnlockThreshold", 35.0f);
        _moteChance = sConfigMgr->GetOption<float>("Branding.Insight.MoteChance", 0.02f);
    }
}

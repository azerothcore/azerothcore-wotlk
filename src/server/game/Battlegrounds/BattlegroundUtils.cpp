#include "BattlegroundUtils.h"
#include "World.h"

uint32 GetMinPlayersPerTeam(Battleground* bg, PvPDifficultyEntry const* bracketEntry)
{
    // The problem addressed here is that methods such as bg->GetMinLevel() and bg->GetMaxLevel() have a different meaning
    // according to whether the BG is a template (then it's the value from the `battleground_template` table)
    // or if it's the real BG (then it's the specific bracket minimum level, e.g. "60" for "60-69").

    if (!bg->isTemplate() || bg->isArena())
    {
        return bg->GetMinPlayersPerTeam();
    }

    auto maxPlayerLevel = sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL);
    auto isMaxLevel = bracketEntry->minLevel <= maxPlayerLevel && maxPlayerLevel <= bracketEntry->maxLevel;
    auto lowLevelsOverride = sWorld->getIntConfig(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS);

    return (lowLevelsOverride && !isMaxLevel) ? lowLevelsOverride : bg->GetMinPlayersPerTeam();
}

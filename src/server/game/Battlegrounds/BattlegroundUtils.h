#ifndef BATTLEGROUNDUTILS_H
#define BATTLEGROUNDUTILS_H

#include "Battleground.h"

uint32 GetMinPlayersPerTeam(Battleground* bg, PvPDifficultyEntry const* bracketEntry);

// Effective low-levels MinPlayersPerTeam override for a BG type:
// the per-BG config if set, else the global one. 0 = no override.
// BGs entered through the Random BG queue have BATTLEGROUND_RB as
// their type, so they always resolve through the global key.
uint32 GetLowLevelsMinPlayersOverride(BattlegroundTypeId bgTypeId);

#endif  // BATTLEGROUNDUTILS_H

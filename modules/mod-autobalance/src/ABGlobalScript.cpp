#include "ABGlobalScript.h"

#include "ABConfig.h"
#include "ABMapInfo.h"
#include "ABUtils.h"

void AutoBalance_GlobalScript::OnAfterUpdateEncounterState(Map* map, EncounterCreditType type, uint32 /*creditEntry*/, Unit* /*source*/, Difficulty /*difficulty_fixed*/, DungeonEncounterList const* /*encounters*/, uint32 /*dungeonCompleted*/, bool updated)
{
    //if (!dungeonCompleted)
    //    return;

    if (!rewardEnabled || !updated)
        return;

    AutoBalanceMapInfo* mapABInfo = GetMapInfo(map);

    if (mapABInfo->adjustedPlayerCount < MinPlayerReward)
        return;

    // skip if it's not a pre-wotlk dungeon/raid and if it's not scaled
    if (!LevelScaling || mapABInfo->mapLevel <= 70 || mapABInfo->lfgMinLevel <= 70
        // skip when not in dungeon or not kill credit
        || type != ENCOUNTER_CREDIT_KILL_CREATURE || !map->IsDungeon())
        return;

    Map::PlayerList const& playerList = map->GetPlayers();

    if (playerList.IsEmpty())
        return;

    uint32 reward = map->ToInstanceMap()->GetMaxPlayers() > 5 ? rewardRaid : rewardDungeon;
    if (!reward)
        return;

    //instanceStart=0, endTime;
    uint8 difficulty = map->GetDifficulty();

    for (Map::PlayerList::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
    {
        if (!itr->GetSource() || itr->GetSource()->IsGameMaster() || itr->GetSource()->GetLevel() < DEFAULT_MAX_LEVEL)
            continue;

        itr->GetSource()->AddItem(reward, 1 + difficulty); // difficulty boost
    }
}

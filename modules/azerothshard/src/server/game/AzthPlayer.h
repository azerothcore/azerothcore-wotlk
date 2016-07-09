#ifndef AZTHPLAYER_H
#define AZTHPLAYER_H

#include "Config.h"
#include "Define.h"
#include "Player.h"

/* [TODO] fix and re-enable */
 class AzthPlayer {
 public:
     explicit AzthPlayer(Player *origin);
     ~AzthPlayer();

//     void SetPlayerQuestRate(float rate);
//
//     /**
//             Get player quest rate. If player hasn't set it before, returns server configuration
//
//             @returns Quest Rate. If player set his own, return it; if he hasn't it returns server default
//      */
//     float GetPlayerQuestRate();
//
//     /**
//
//             Get Player team considering CrossFactionGroups: If player is in a group returns group leader's team
//
//                     @param Unit race (Unused, kept for compatibility)
//                     @returns Group leader team  if player is in a group, -1 for default
//      */
//     bool setFactionForRace(uint8 race);
//     uint32 getOriginalTeam();
//
     uint32 getArena1v1Info(uint8 type);
     void setArena1v1Info(uint8 type, uint32 value);
//
 private:
     Player *player;
     uint32 arena1v1Info[7]; // ARENA_TEAM_END
//
     float playerQuestRate, maxQuestRate;
 };

#endif /* AZTHPLAYER_H */


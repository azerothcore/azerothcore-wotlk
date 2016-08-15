#ifndef AZTHPLAYER_H
#define AZTHPLAYER_H

#include "Config.h"
#include "Define.h"
#include "Player.h"
#include "CrossFaction.h"

class CrossFaction;
class Player;

class AzthPlayer {
 public:
     explicit AzthPlayer(Player *origin);
     ~AzthPlayer();

     void SetPlayerQuestRate(float rate);

     /**
             Get player quest rate. If player hasn't set it before, returns server configuration

             @returns Quest Rate. If player set his own, return it; if he hasn't it returns server default
      */
     float GetPlayerQuestRate();

     uint32 getArena1v1Info(uint8 type);
     void setArena1v1Info(uint8 type, uint32 value);
    
    uint16 levelPlayer;
    uint16 tmpLevelPg;
    uint8 groupLevel;

    struct AzthAchiData
    {
        uint8 level;
        uint8 levelParty;
    };

    typedef UNORDERED_MAP<uint16 /*achiId*/, AzthAchiData /*data*/> CompletedAchievementMap;
    CompletedAchievementMap m_completed_achievement_map;

    typedef UNORDERED_MAP<uint16 /*critId*/, AzthAchiData /*data*/> CompletedCriteriaMap;
    CompletedCriteriaMap m_completed_criteria_map;

    uint32 instanceID;
    
    uint8 getGroupLevel();

    void ForceKilledMonsterCredit(uint32 entry, uint64 guid);

 private:
     Player *player;
     uint32 arena1v1Info[7]; // ARENA_TEAM_END

     float playerQuestRate, maxQuestRate;
 };

#endif /* AZTHPLAYER_H */


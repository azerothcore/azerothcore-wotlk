/**
    This plugin can be used for common player customizations
 */

// #include "ScriptMgr.h"
// #include "InstanceScript.h"
// #include "InstanceSaveMgr.h"
// #include "Player.h"
// #include "Map.h"

// class AzthPlayerPlg : public PlayerScript {
// public:
//
//     AzthPlayerPlg() : PlayerScript("AzthPlayerPlg") { }
//
//     uint16 levelPlayer;
//     uint16 tmpLevelPg;
//
//     struct CompletedAchievementData
//     {
//         uint8 level;
//     };
//
//     typedef std::unordered_map<uint16 /*achiId*/, CompletedAchievementData /*data*/> CompletedAchievementMap;
//     CompletedAchievementMap m_completed_achievement_map;
//     uint32 instanceID;
//
//     void OnLogin(Player* player, bool firstLogin) override {
//         // do it again for crossfaction system
//         player->setFactionForRace(player->getRace());
//     }
//
//     void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea) override {
//         player->setFactionForRace(player->getRace());
//
//         return; // disable following
//
//         Map* map = player->FindMap();
//         uint16 levelPlayer = player->getLevel();
//
//         if (map->IsDungeon()) {
//             InstanceSave* is=player->GetInstanceSave(map->GetId(),map->IsRaid());
//
//             if (is->azthInstMgr->levelMax == 0) {
//                 instanceID = map->GetInstanceId();
//
//                 QueryResult result = CharacterDatabase.PQuery("SELECT levelPg FROM instance WHERE id = %u", instanceID);
//                 if (!result)
//                     return;
//                 Field* fields = result->Fetch();
//                 is->azthInstMgr->levelMax = fields[0].GetUInt32();
//             }
//
//             if (levelPlayer > is->azthInstMgr->levelMax) {
//                 is->azthInstMgr->levelMax = levelPlayer;
//                 is->SaveToDB();
//             }
//         }
//     }
//
//     void OnAchiComplete(Player *player, AchievementEntry const* achievement) override {
//         return;  // disable following
//
//         uint16 levelPlayer = player->getLevel();
//
//         Map* map = player->FindMap();
//         if (map->IsDungeon()) {
//             InstanceSave* is=player->GetInstanceSave(map->GetId(),map->IsRaid());
//             if (is->azthInstMgr->levelMax!=0) {
//                 levelPlayer = is->azthInstMgr->levelMax;
//             }
//         }
//
//         CompletedAchievementData& it = m_completed_achievement_map[achievement->ID];
//         it.level = levelPlayer;
//     }
//
//     void OnAchiSave(Player *player, uint16 achId) override {
//         return;  // disable following
//
//         CompletedAchievementData& it = m_completed_achievement_map[achId];
//
//         CharacterDatabase.PExecute("UPDATE character_achievement SET levelPg = %u WHERE achievement = %u", it.level, achId);
//         m_completed_achievement_map.erase(achId);
//     }
// };
//
// void AddSC_azth_player_plg() {
//     new AzthPlayerPlg();
// }


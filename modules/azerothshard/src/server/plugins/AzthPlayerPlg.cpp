/**
    This plugin can be used for common player customizations
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "InstanceSaveMgr.h"
#include "Player.h"
#include "Map.h"
#include "WorldSession.h"

class AzthPlayerPlg : public PlayerScript{
public:

    AzthPlayerPlg() : PlayerScript("AzthPlayerPlg") { }

    uint16 levelPlayer;
    uint16 tmpLevelPg;

    struct CompletedAchievementData
    {
        uint8 level;
    };

    typedef UNORDERED_MAP<uint16 /*achiId*/, CompletedAchievementData /*data*/> CompletedAchievementMap;
    CompletedAchievementMap m_completed_achievement_map;
    uint32 instanceID;

    void OnLevelChanged(Player* player, uint8 oldLevel) override
    {
        if (oldLevel == 9)
        {
            sWorld->SendGameMail(player, "Well done!", "You reached level 10, a small present for you!", 10 * GOLD);
        }
    }

    void OnLogin(Player* player) override {
        // do it again for crossfaction system
        player->setFactionForRace(player->getRace());
    }

    void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea) override {
        player->setFactionForRace(player->getRace());
        
        Map* map = player->FindMap();
        uint16 levelPlayer = player->getLevel();


        if (map->IsDungeon()) {
            InstanceSave* is = sInstanceSaveMgr->PlayerGetInstanceSave(GUID_LOPART(player->GetGUID()), map->GetId(), player->GetDifficulty(map->IsRaid()));
            if (is->azthInstMgr->levelMax == 0) {
                instanceID = map->GetInstanceId();

                QueryResult result = CharacterDatabase.PQuery("SELECT levelPg FROM instance WHERE id = %u", instanceID);
                if (!result)
                    return;
                Field* fields = result->Fetch();
                is->azthInstMgr->levelMax = fields[0].GetUInt32();
            }

            if (levelPlayer > is->azthInstMgr->levelMax) {
                is->azthInstMgr->levelMax = levelPlayer;
                is->InsertToDB();
            }
        }
    }

    void OnAchiComplete(Player *player, AchievementEntry const* achievement) override {

        uint16 levelPlayer = player->getLevel();

        Map* map = player->FindMap();
        if (map->IsDungeon()) {
            InstanceSave* is = sInstanceSaveMgr->PlayerGetInstanceSave(GUID_LOPART(player->GetGUID()), map->GetId(), player->GetDifficulty((map->IsRaid())));
            if (is->azthInstMgr->levelMax!=0) {
                levelPlayer = is->azthInstMgr->levelMax;
            }
        }

        CompletedAchievementData& it = m_completed_achievement_map[achievement->ID];
        it.level = levelPlayer;
    }

    void OnAchiSave(Player *player, uint16 achId) override {

        CompletedAchievementData& it = m_completed_achievement_map[achId];

        CharacterDatabase.PExecute("UPDATE character_achievement SET levelPg = %u WHERE achievement = %u", it.level, achId);
        m_completed_achievement_map.erase(achId);
    }
};

class AzthGroupPlg : public GroupScript {
public:

    AzthGroupPlg() : GroupScript("AzthGroupPlg") { }

    void OnAddMember(Group* group, uint64 guid) override {
        Player* player = ObjectAccessor::FindPlayer(guid);
        if (group->azthGroupMgr->levelMaxGroup < player->getLevel()) {
            group->azthGroupMgr->levelMaxGroup = player->getLevel();
            group->azthGroupMgr->saveToDb();
        }
    }
};

void AddSC_azth_player_plg() {
    new AzthPlayerPlg();
    new AzthGroupPlg();
}


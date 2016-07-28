/**
    This plugin can be used for common player customizations
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "InstanceSaveMgr.h"
#include "Player.h"
#include "Map.h"
#include "WorldSession.h"
#include "AchievementMgr.h"
#include "AzthGroupMgr.h"

enum achievementStatsType {
    ACHIEVEMENT_TYPE,
    CRITERIA_TYPE
};

class AzthPlayerPlg : public PlayerScript{
public:

    AzthPlayerPlg() : PlayerScript("AzthPlayerPlg") { }

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

    // Following 2 functions store levels in a temporary map
    void OnAchiComplete(Player *player, AchievementEntry const* achievement) override {
        AzthAchiData& it = m_completed_achievement_map[achievement->ID];
        it.level = player->getLevel();
        it.levelParty = getGroupLevel(player);
    }

    void OnCriteriaProgress(Player *player, AchievementCriteriaEntry const* criteria) override {
        AzthAchiData& it = m_completed_criteria_map[criteria->ID];
        it.level = player->getLevel();
        it.levelParty = getGroupLevel(player);
    }

    // Following 2 functions save our temporary maps inside the db
    void OnAchiSave(SQLTransaction& trans, Player *player, uint16 achId, CompletedAchievementData achiData) override {

        AzthAchiData& it = m_completed_achievement_map[achId];
        uint32 index = 0;
        
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PVESTATS);
        stmt->setUInt32(index++, player->GetGUID());
        stmt->setUInt32(index++, achId);
        stmt->setUInt32(index++, ACHIEVEMENT_TYPE);
        stmt->setUInt32(index++, it.level);
        stmt->setUInt32(index++, it.levelParty);
        stmt->setUInt32(index++, achiData.date);
        trans->Append(stmt);

        m_completed_achievement_map.erase(achId);
    }

    void OnCriteriaSave(SQLTransaction& trans, Player* player, uint16 critId, CriteriaProgress criteriaData) override {

        AzthAchiData& it = m_completed_criteria_map[critId];
        uint32 index = 0;

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PVESTATS);
        stmt->setUInt32(index++, player->GetGUID());
        stmt->setUInt32(index++, critId);
        stmt->setUInt32(index++, CRITERIA_TYPE);
        stmt->setUInt32(index++, it.level);
        stmt->setUInt32(index++, it.levelParty);
        stmt->setUInt32(index++, criteriaData.date);
        trans->Append(stmt);

        m_completed_criteria_map.erase(critId);
    }

private:
    uint8 getGroupLevel(Player *player) {
        uint8 groupLevel = 0;

        Group *group = player->GetGroup();
        Map* map = player->FindMap();
        if (group) {
            if (map->IsDungeon()) {
                // caso party instance
                InstanceSave* is = sInstanceSaveMgr->PlayerGetInstanceSave(GUID_LOPART(player->GetGUID()), map->GetId(), player->GetDifficulty((map->IsRaid())));
                groupLevel = is->azthInstMgr->levelMax;
            } else {
                // caso party esterno
                groupLevel = group->azthGroupMgr->levelMaxGroup;
            }
        }

        return groupLevel;
    }
};



void AddSC_azth_player_plg() {
    new AzthPlayerPlg();
}

